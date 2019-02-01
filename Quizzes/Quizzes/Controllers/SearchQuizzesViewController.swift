//
//  SearchViewController.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class SearchQuizzesViewController: UIViewController {
    
    let searchQuizzesView = SearchQuizzesView()
    
    private var quizzes = [Quiz]() {
        didSet {
            DispatchQueue.main.async {
                self.searchQuizzesView.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(searchQuizzesView)
        searchQuizzesView.collectionView.dataSource = self
        searchQuizzesView.collectionView.delegate = self
        getQuizzes()
    }
    
    fileprivate func getQuizzes() {
        QuizAPIClient.getQuizzes { (appError, quizzes) in
            if let appError = appError {
                print("getQuizzes error - \(appError)")
            } else if let quizzes = quizzes {
                self.quizzes = quizzes
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func addQuiz(sender: SearchCell) {
        let quiz = quizzes[sender.tag]
        let quizTitle = quiz.quizTitle
        guard !SavedQuizModel.isDuplicate(quizTitle: quizTitle) else {
            showAlert(title: "Duplicate", message: "\(quizTitle) already exist in your quizzes")
            return
        }
        let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate,
                                          .withFullTime,
                                          .withInternetDateTime,
                                          .withTimeZone,
                                          .withDashSeparatorInDate]
        let timeStamp = isoDateFormatter.string(from: date)
        
        let quizToSave = SavedQuiz.init(quizTitle: quizTitle, facts: quiz.facts, addedDate: timeStamp)
        SavedQuizModel.add(newQuiz: quizToSave)
         showAlert(title: "Success", message: "\(quizTitle) successfully added to your quizzes")
    }
}

extension SearchQuizzesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let searchCell = searchQuizzesView.collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCell else { return UICollectionViewCell() }
        searchCell.quizTitleLabel.text = quizzes[indexPath.row].quizTitle
        searchCell.addButton.tag = indexPath.row
        searchCell.addButton.addTarget(self, action: #selector(addQuiz), for: .touchUpInside)
        return searchCell
    }
    

}