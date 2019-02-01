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
    
    public lazy var userImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "placeholder-image")
        iv.layer.cornerRadius = iv.bounds.width / 2.0
        return iv
    }()


    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        userImage.layer.cornerRadius = userImage.bounds.width / 2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        addSubview(userImageButton)
        setupUserImageButton()
    }

}
extension ProfileView {
    private func setupUserImageButton() {
        userImageButton.translatesAutoresizingMaskIntoConstraints = false
        [userImageButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 22),
         userImageButton.centerXAnchor.constraint(equalTo: centerXAnchor),
         userImageButton.widthAnchor.constraint(equalToConstant: 100),
         userImageButton.heightAnchor.constraint(equalToConstant: 100)].forEach{ $0.isActive = true }
    }
}
