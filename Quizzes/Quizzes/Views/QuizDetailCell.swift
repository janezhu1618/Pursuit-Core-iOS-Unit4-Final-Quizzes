//
//  QuizDetailCell.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class QuizDetailCell: UICollectionViewCell {
    public lazy var quizLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
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
        backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        addSubview(quizLabel)
        setupQuizLabel()
    }
}

extension QuizDetailCell {
    private func setupQuizLabel() {
        quizLabel.translatesAutoresizingMaskIntoConstraints = false
        [quizLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
         quizLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
         quizLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
         quizLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
         ].forEach{ $0.isActive = true }
    }
    
}
