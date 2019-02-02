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
    
    private var savedQuizzes = [SavedQuiz]()
    
    //TODO: finish implementing searchbar delegation, search results should be able to be deleted at the right index number
    
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
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(true)
//        savedQuizzes.removeAll()
//    }
    
    fileprivate func getSavedQuizzes() {
        savedQuizzes = SavedQuizModel.getSavedQuizzes().savedQuiz
        navigationItem.title = "Quizzes (\(savedQuizzes.count))"
        if savedQuizzes.isEmpty {
            quizView.collectionView.backgroundView = quizNoDataView
        } else {
            quizView.collectionView.backgroundView = nil
            quizView.collectionView.reloadData()
        }
    }

}

extension QuizViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedQuizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let quizCell = quizView.collectionView.dequeueReusableCell(withReuseIdentifier: "QuizCell", for: indexPath) as? QuizCell else { return UICollectionViewCell() }
        quizCell.quizTitleLabel.text = savedQuizzes[indexPath.row].quizTitle
        quizCell.moreOptionsButton.tag = indexPath.row
        quizCell.moreOptionsButton.addTarget(self, action: #selector(moreOptionsPressed), for: .touchUpInside)
        return quizCell
    }
    
    @objc private func moreOptionsPressed(sender: QuizCell) {
        let alert = UIAlertController(title: "", message: "What would you like to do?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            SavedQuizModel.delete(atIndex: sender.tag)
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
        savedQuizzes = savedQuizzes.filter{ $0.quizTitle.lowercased().prefix(searchText.count) == searchText.lowercased() }
        quizView.collectionView.reloadData()
    }
}
