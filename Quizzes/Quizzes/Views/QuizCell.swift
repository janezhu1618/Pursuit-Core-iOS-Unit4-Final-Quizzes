//
//  QuizCell.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class QuizCell: UICollectionViewCell {
    public lazy var quizTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var moreOptionsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "more-filled"), for: .normal)
        return button
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
        addSubview(quizTitleLabel)
        addSubview(moreOptionsButton)
        setupQuizTitleLabel()
        setupMoreOptionsButton()
    }
}

extension QuizCell {
    private func setupQuizTitleLabel() {
        quizTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        [quizTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
         quizTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
         quizTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
         quizTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
         ].forEach{ $0.isActive = true }
    }
    
    private func setupMoreOptionsButton() {
        moreOptionsButton.translatesAutoresizingMaskIntoConstraints = false
        [moreOptionsButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
         moreOptionsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
         moreOptionsButton.heightAnchor.constraint(equalToConstant: 30),
         moreOptionsButton.widthAnchor.constraint(equalToConstant: 30),
         ].forEach{ $0.isActive = true }
    }
}

