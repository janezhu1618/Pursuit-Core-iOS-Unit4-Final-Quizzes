//
//  SearchCell.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    public lazy var quizTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add-icon-filled"), for: .normal)
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
        backgroundColor = .white
        addSubview(quizTitleLabel)
        addSubview(addButton)
        setupQuizTitleLabel()
        setupAddButton()
    }
}

extension SearchCell {
    private func setupQuizTitleLabel() {
        quizTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        [quizTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
         quizTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
         quizTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
         quizTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            ].forEach{ $0.isActive = true }
    }
    
    private func setupAddButton() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        [addButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
         addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
         addButton.heightAnchor.constraint(equalToConstant: 30),
         addButton.widthAnchor.constraint(equalToConstant: 30),
            ].forEach{ $0.isActive = true }
    }
}
