//
//  QuizNoDataView.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class QuizNoDataView: UIView {

    public lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Quiz data empty.\nStart adding or creating quizzes."
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
        backgroundColor = .white
        setupMessageLabel()
    }
}

extension QuizNoDataView {
    private func setupMessageLabel() {
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        [messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22)
            ].forEach{ $0.isActive = true }
    }
}
