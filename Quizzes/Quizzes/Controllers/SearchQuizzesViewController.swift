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
    
    public var quizzes = [Quiz]() {
        didSet {
            DispatchQueue.main.async {
                self.searchQuizzesView.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Quizzes"
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
}

extension SearchQuizzesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let searchCell = searchQuizzesView.collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCell else { return UICollectionViewCell() }
        searchCell.quizTitleLabel.text = quizzes[indexPath.row].quizTitle
        return searchCell
    }
    

}
