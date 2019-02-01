//
//  QuizDetailView.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class QuizDetailView: UIView {
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 400, height: 200)
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
        collectionView.register(QuizDetailCell.self, forCellWithReuseIdentifier: "QuizDetailCell")
        addSubview(collectionView)
        setupCollectionView()
    }
    
}

extension QuizDetailView {
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        [collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
         collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
         collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
         collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
            ].forEach{ $0.isActive = true }
    }
}

