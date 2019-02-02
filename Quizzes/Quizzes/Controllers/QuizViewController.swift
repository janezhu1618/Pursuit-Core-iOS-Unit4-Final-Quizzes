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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getSavedQuizzes()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(quizView)
        quizView.collectionView.dataSource = self
        quizView.collectionView.delegate = self
    }
    
    fileprivate func getSavedQuizzes() {
        savedQuizzes = SavedQuizModel.getSavedQuizzes()
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
