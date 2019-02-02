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
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func createQuiz() {
        guard let titleText = createView.quizTitleTextField.text,
            let fact1 = createView.quizFact1TextView.text,
            let fact2 = createView.quizFact1TextView.text else {
            showAlert(title: "Error", message: "Make sure all fields are filled in.")
            return
        }
        if titleText != quizTitleTextFieldPlaceholder && fact1 != quizFact1TextViewPlaceholder && fact2 != quizFact2TextViewPlaceholder {
            if UserDefaults.standard.object(forKey: UserDefaultsKey.username) == nil {
                showAlert(title: "Unidentified User", message: "Please log in with username in Profile Screen first.")
            } else {
                let date = Date()
                let isoDateFormatter = ISO8601DateFormatter()
                isoDateFormatter.formatOptions = [.withFullDate,
                                                  .withFullTime,
                                                  .withInternetDateTime,
                                                  .withTimeZone,
                                                  .withDashSeparatorInDate]
                let timeStamp = isoDateFormatter.string(from: date)
                let quizToSave = SavedQuiz.init(quizTitle: titleText, facts: [fact1, fact2], addedDate: timeStamp)
                SavedQuizModel.add(newQuiz: quizToSave)
                setupTextFieldAndTextView()
                showAlert(title: "Success", message: "Quiz added to list.")
            }
        } else {
            showAlert(title: "Error", message: "Make sure to enter all fields.")
        }
    }
    
    fileprivate func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createQuiz))
   //     navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
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

