//
//  QuizView.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class QuizView: UIView {
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 190, height: 190)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
        
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.backgroundColor = .red
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        collectionView.register(QuizCell.self, forCellWithReuseIdentifier: "QuizCell")
        addSubview(collectionView)
        setupCollectionView()
    }

}

extension QuizView {
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        [collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
         collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
         collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
         collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
            ].forEach{ $0.isActive = true }
    }
}
