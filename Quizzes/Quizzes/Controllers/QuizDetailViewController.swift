//
//  QuizDetailViewController.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class QuizDetailViewController: UIViewController {
    
    public var savedQuiz: SavedQuiz!
    
    private let quizDetailView = QuizDetailView()
    
    init(quiz: SavedQuiz) {
        super.init(nibName: nil, bundle: nil)
        self.savedQuiz = quiz
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Quiz Detail"
        view.addSubview(quizDetailView)
        quizDetailView.collectionView.dataSource = self
        quizDetailView.collectionView.delegate = self
    }
    


}
extension QuizDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedQuiz.facts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let quizDetailCell = quizDetailView.collectionView.dequeueReusableCell(withReuseIdentifier: "QuizDetailCell", for: indexPath) as? QuizDetailCell else { return UICollectionViewCell() }
        quizDetailCell.quizLabel.text = savedQuiz.quizTitle
        return quizDetailCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = quizDetailView.collectionView.cellForItem(at: indexPath) as? QuizDetailCell else { return }
        UIView.animate(withDuration: 0.5, delay: 0, options: [.transitionFlipFromLeft], animations: {
        cell.transform = CGAffineTransform(scaleX: -1, y: 1)
        cell.quizLabel.isHidden = true
    }) { (done) in
        cell.transform = CGAffineTransform.identity
        cell.quizLabel.isHidden = false
        cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        if cell.quizLabel.text == self.savedQuiz.quizTitle {
            cell.quizLabel.text = self.savedQuiz.facts[indexPath.row]
        } else {
            cell.quizLabel.text = self.savedQuiz.quizTitle
        }
        }
    }
}
