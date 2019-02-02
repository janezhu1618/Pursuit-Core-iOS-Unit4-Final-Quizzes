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
    private var isImageFromCamera = false
    
    private var username = "" {
        didSet {
            profileView.usernameButton.setTitle("@" + username, for: .normal)
        }
    }
    
    fileprivate func checkForUserDefaultsSetting() {
        if let username = UserDefaults.standard.object(forKey: UserDefaultsKey.username) as? String {
            self.username = username
            if let userImage = SavedQuizModel.getSavedQuizzes().userImage {
                profileView.userImageButton.setImage(UIImage(data: userImage), for: .normal)
            } else {
                profileView.userImageButton.setImage(UIImage(named: "placeholder-image"), for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        navigationItem.title = "Profile"
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        profileView.userImageButton.addTarget(self, action: #selector(presentActionSheet), for: .touchUpInside)
        profileView.usernameButton.addTarget(self, action: #selector(changeUser), for: .touchUpInside)
        checkForUserDefaultsSetting()
    }

    
    @objc private func changeUser() {
        let alert = UIAlertController(title: "Log in", message: "Enter your username", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Username"
            textField.textAlignment = .center
        }
//        alert.addTextField { (textField) in
//            textField.placeholder = "Password"
//            textField.textAlignment = .center
//            textField.isSecureTextEntry = true
//        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (submit) in
            guard let username = alert.textFields?.first?.text else {
                print("username nil")
                return }
            self.profileView.usernameButton.setTitle("@" + username, for: .normal)
            self.username = username
//            SavedQuizModel.savedQuizzes.removeAll()
            UserDefaults.standard.set(username, forKey: UserDefaultsKey.username)
            self.checkForUserDefaultsSetting()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func presentActionSheet() {
        let alert = UIAlertController(title: "", message: "Choose a new user photo?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            self.imagePickerViewController.sourceType = .photoLibrary
            self.showImagePickerViewController()
        }))
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.imagePickerViewController.sourceType = .camera
            self.isImageFromCamera = true
            self.showImagePickerViewController()
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showImagePickerViewController() {
        present(imagePickerViewController, animated: true, completion: nil)
    }
    
    private func saveImageToPhotoLibrary() {
        guard let selectedImage = profileView.userImageButton.imageView?.image else {
            print("no image to be saved")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
//help source with saving photo from camera https://stackoverflow.com/questions/40854886/swift-take-a-photo-and-save-to-photo-library
    
    private enum ImageSource {
        case camera
        case photoLibrary
    }
    
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            showAlert(title: "Save error", message: error.localizedDescription)
        } else {
            showAlert(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileView.userImageButton.setImage(image, for: .normal)
            if let imageToSave = image.jpegData(compressionQuality: 0.5) {
                SavedQuizModel.saveUserImage(newImage: imageToSave)
            }
            if isImageFromCamera {
                saveImageToPhotoLibrary()
            }
            } else {
            print("original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}
