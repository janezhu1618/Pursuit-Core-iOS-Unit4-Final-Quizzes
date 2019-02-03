//
//  QuizViewController.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    private let quizView = QuizView()
    private let quizNoDataView = QuizNoDataView()
    
    private var savedQuizzes = [SavedQuiz]() {
        didSet {
            quizView.collectionView.reloadData()
        }
    }
    
    private var searchResults = [SavedQuiz]() {
        didSet {
            quizView.collectionView.reloadData()
        }
    }
    private var isSearching = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getSavedQuizzes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(quizView)
        quizView.searchBar.delegate = self
        quizView.collectionView.dataSource = self
        quizView.collectionView.delegate = self
        setupKeyboardToolbar()
    }
    
    fileprivate func setupKeyboardToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done
            , target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        quizView.searchBar.inputAccessoryView = toolbar
    }
    //source https://medium.com/@KaushElsewhere/how-to-dismiss-keyboard-in-a-view-controller-of-ios-3b1bfe973ad1
    @objc private func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    
    fileprivate func getSavedQuizzes() {
        savedQuizzes = SavedQuizModel.getSavedQuizzes().savedQuiz
        navigationItem.title = "Quizzes (\(savedQuizzes.count))"
        if savedQuizzes.isEmpty {
            quizView.collectionView.backgroundView = quizNoDataView
        } else {
            quizView.collectionView.backgroundView = nil
        }
    }

}

extension QuizViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return searchResults.count
        } else {
            return savedQuizzes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let quizCell = quizView.collectionView.dequeueReusableCell(withReuseIdentifier: "QuizCell", for: indexPath) as? QuizCell else { return UICollectionViewCell() }
        if isSearching {
            quizCell.quizTitleLabel.text = searchResults[indexPath.row].quizTitle
        } else {
            quizCell.quizTitleLabel.text = savedQuizzes[indexPath.row].quizTitle
        }
        quizCell.moreOptionsButton.tag = indexPath.row
        quizCell.moreOptionsButton.addTarget(self, action: #selector(moreOptionsPressed), for: .touchUpInside)
        return quizCell
    }
    
    @objc private func moreOptionsPressed(sender: QuizCell) {
        let alert = UIAlertController(title: "", message: "What would you like to do?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            if self.isSearching {
                SavedQuizModel.deleteSpecificQuiz(quizToDelete: self.searchResults[sender.tag])
            } else {
                SavedQuizModel.delete(atIndex: sender.tag)
            }
            self.isSearching = false
            self.getSavedQuizzes()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let quizDetailVC = QuizDetailViewController(quiz: savedQuizzes[indexPath.row])
        navigationController?.pushViewController(quizDetailVC, animated: true)
    }
}

extension QuizViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults = savedQuizzes
        searchResults = savedQuizzes.filter{ $0.quizTitle.lowercased().contains(searchText.lowercased()) || $0.quizTitle.lowercased().hasPrefix(searchText.lowercased()) }
        isSearching = true
    }
    
}
