//
//  QuizDetailViewController.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

//TODO: animate collectionviewcell

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
        quizDetailCell.quizLabel.text = savedQuiz.facts[indexPath.row]
        return quizDetailCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collection view cell pressed at \(indexPath.row)")
    let cell = quizDetailView.collectionView.cellForItem(at: indexPath)
    UIView.animate(withDuration: 3, delay: 0.3, options: [.transitionFlipFromLeft], animations: {
        cell?.transform = CGAffineTransform(rotationAngle: 90)
        
    }, completion: nil)
    }
}
