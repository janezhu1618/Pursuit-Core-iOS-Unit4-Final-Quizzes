//
//  ProfileView.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    public lazy var userImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "placeholder-image"), for: .normal)
        //button.layer.cornerRadius = button.bounds.width / 2.0
        return button
    }()
    
    public lazy var usernameButton: UIButton = {
        let button = UIButton()
        button.setTitle("@noUsernameYet", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        userImageButton.layer.cornerRadius = userImageButton.bounds.width / 2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        setupUserImageButton()
        setupUsernameButton()
    }

}
extension ProfileView {
    private func setupUserImageButton() {
        addSubview(userImageButton)
        userImageButton.translatesAutoresizingMaskIntoConstraints = false
        [userImageButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 22),
         userImageButton.centerXAnchor.constraint(equalTo: centerXAnchor),
         userImageButton.widthAnchor.constraint(equalToConstant: 200),
         userImageButton.heightAnchor.constraint(equalToConstant: 200)
            ].forEach{ $0.isActive = true }
    }
    
    private func setupUsernameButton() {
        addSubview(usernameButton)
        usernameButton.translatesAutoresizingMaskIntoConstraints = false
        [usernameButton.topAnchor.constraint(equalTo: userImageButton.bottomAnchor, constant: 22),
         usernameButton.centerXAnchor.constraint(equalTo: centerXAnchor)
         ].forEach{ $0.isActive = true }
    }
}
