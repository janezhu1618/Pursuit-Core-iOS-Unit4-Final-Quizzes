//
//  ProfileViewController.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    private let profileView = ProfileView()
    
    private var imagePickerViewController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        navigationItem.title = "Profile"
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        profileView.userImageButton.addTarget(self, action: #selector(presentActionSheet), for: .touchUpInside)
    }
    @objc private func presentActionSheet() {
        let alert = UIAlertController(title: "", message: "Choose a new user photo?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            self.imagePickerViewController.sourceType = .photoLibrary
            self.showImagePickerViewController()
        }))
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("no camera available")
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.imagePickerViewController.sourceType = .camera
            self.showImagePickerViewController()
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showImagePickerViewController() {
        present(imagePickerViewController, animated: true, completion: nil)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileView.userImageButton.setImage(image, for: .normal)        } else {
            print("original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}
