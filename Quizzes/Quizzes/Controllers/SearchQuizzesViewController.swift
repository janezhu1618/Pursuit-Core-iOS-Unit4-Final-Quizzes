//
//  SearchViewController.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class SearchQuizzesViewController: UIViewController {
    
    private let searchQuizzesView = SearchQuizzesView()
    private var quizzes = [Quiz]()
    
    //setting the searchquizzes result to a new variable does not affect the original search results and allows the list (quizzes) to update dynamically between searches
    private var searchResultsQuiz = [Quiz]()
    private var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search Quizzes"
        self.view.addSubview(searchQuizzesView)
        searchQuizzesView.searchBar.delegate = self
        searchQuizzesView.collectionView.dataSource = self
        searchQuizzesView.collectionView.delegate = self
        getQuizzes()
    }
    
    fileprivate func getQuizzes() {
        QuizAPIClient.getQuizzes { (appError, quizzes) in
            if let appError = appError {
                print("getQuizzes error - \(appError)")
            } else if let quizzes = quizzes {
                self.quizzes = quizzes.sorted{ $0.quizTitle < $1.quizTitle }
                DispatchQueue.main.async {
                    self.searchQuizzesView.collectionView.reloadData()
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension SearchQuizzesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return searchResultsQuiz.count
        } else {
        return quizzes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let searchCell = searchQuizzesView.collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCell else { return UICollectionViewCell() }
        if isSearching {
            searchCell.quizTitleLabel.text = searchResultsQuiz[indexPath.row].quizTitle

        } else {
            searchCell.quizTitleLabel.text = quizzes[indexPath.row].quizTitle
        }
        searchCell.addButton.tag = indexPath.row
        searchCell.addButton.addTarget(self, action: #selector(addQuiz), for: .touchUpInside)
        return searchCell
    }
    
    @objc private func addQuiz(sender: SearchCell) {
        var quiz = quizzes[sender.tag]
        if isSearching {
            quiz = searchResultsQuiz[sender.tag]
        }
        let quizTitle = quiz.quizTitle
        guard !SavedQuizModel.isDuplicate(quizTitle: quizTitle) else {
            showAlert(title: "Duplicate", message: "\(quizTitle) already exists in quizzes")
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
        let quizToSave = SavedQuiz.init(id: SavedQuizModel.userProfile.savedQuiz.count+1, quizTitle: quizTitle, facts: quiz.facts, addedDate: timeStamp)
        SavedQuizModel.add(newQuiz: quizToSave)
        showAlert(title: "Success", message: "\(quizTitle) is successfully added to quizzes")
    }
}


extension SearchQuizzesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResultsQuiz = quizzes.filter{ $0.quizTitle.lowercased().contains(searchText.lowercased()) }
        isSearching = true
        searchQuizzesView.collectionView.reloadData()
    }
}
