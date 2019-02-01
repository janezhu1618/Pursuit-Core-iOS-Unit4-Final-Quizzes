//
//  CreateView.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class CreateView: UIView {
    
    public lazy var quizTitleTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 3
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.darkGray.cgColor
        return tf
    }()
    
    public lazy var quizFact1TextView: UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 3
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.darkGray.cgColor
        tv.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return tv
    }()
    
    public lazy var quizFact2TextView: UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 3
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.darkGray.cgColor
        tv.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return tv
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
        addSubview(quizTitleTextField)
        addSubview(quizFact1TextView)
        addSubview(quizFact2TextView)
        setupQuizTitleTextField()
        setupQuizFact1TextView()
        setupQuizFact2TextView()
    }

}

extension CreateView {
    private func setupQuizTitleTextField() {
        quizTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        [quizTitleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 22),
         quizTitleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
         quizTitleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
         quizTitleTextField.heightAnchor.constraint(equalToConstant: 50)
            ].forEach{ $0.isActive = true }
    }
    
    private func setupQuizFact1TextView() {
        quizFact1TextView.translatesAutoresizingMaskIntoConstraints = false
        [quizFact1TextView.topAnchor.constraint(equalTo: quizTitleTextField.bottomAnchor, constant: 22),
         quizFact1TextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
         quizFact1TextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
         quizFact1TextView.heightAnchor.constraint(equalToConstant: 100)
            
            ].forEach{ $0.isActive = true }
    }
    
    private func setupQuizFact2TextView() {
        quizFact2TextView.translatesAutoresizingMaskIntoConstraints = false
        [quizFact2TextView.topAnchor.constraint(equalTo: quizFact1TextView.bottomAnchor, constant: 22),
         quizFact2TextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
         quizFact2TextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
         quizFact2TextView.heightAnchor.constraint(equalToConstant: 100)
            ].forEach{ $0.isActive = true }
    }
}
