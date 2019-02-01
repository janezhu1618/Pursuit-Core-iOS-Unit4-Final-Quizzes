//
//  CreateViewController.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    private let createView = CreateView()
    private let quizTitleTextFieldPlaceholder = "Enter a title"
    private let quizFact1TextViewPlaceholder = "Enter Fact #1"
    private let quizFact2TextViewPlaceholder = "Enter Fact #2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createView)
       
        setupTextFieldAndTextView()
         setupNavBar()
        createView.quizTitleTextField.delegate = self
        createView.quizFact1TextView.delegate = self
        createView.quizFact2TextView.delegate = self
    }
    
    @objc private func createQuiz() {
        print("create button pressed")
    }
    
    fileprivate func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createQuiz))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        navigationItem.title = "Create Quiz"
    }
    
    fileprivate func setupTextFieldAndTextView() {
        createView.quizTitleTextField.text = quizTitleTextFieldPlaceholder
        createView.quizFact1TextView.text = quizFact1TextViewPlaceholder
        createView.quizFact2TextView.text = quizFact2TextViewPlaceholder
        createView.quizTitleTextField.textColor = .darkGray
        createView.quizFact1TextView.textColor = .darkGray
        createView.quizFact2TextView.textColor = .darkGray
    }
}

extension CreateViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if createView.quizTitleTextField.text == quizTitleTextFieldPlaceholder {
            createView.quizTitleTextField.text = ""
            createView.quizTitleTextField.textColor = .black
        }
    }
}

extension CreateViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == createView.quizFact1TextView {
            if createView.quizFact1TextView.text == quizFact1TextViewPlaceholder {
                 createView.quizFact1TextView.text = ""
                 createView.quizFact1TextView.textColor = .black
                }
            }
        if textView == createView.quizFact2TextView {
            if createView.quizFact2TextView.text == quizFact2TextViewPlaceholder {
                createView.quizFact2TextView.text = ""
                createView.quizFact2TextView.textColor = .black
                }
            }
        }
}

