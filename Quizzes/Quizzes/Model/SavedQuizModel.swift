//
//  SavedQuizModel.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

struct SavedQuizModel {
    
    static var userProfile = UserInfo.init(username: UserDefaults.standard.object(forKey: UserDefaultsKey.username) as? String ?? "", userImage: UIImage(named: "placeholder-image")?.jpegData(compressionQuality: 0.5), savedQuiz: [SavedQuiz]())
    //static var savedQuizzes = [SavedQuiz]()
    
    static public func getfilename() -> String {
        return "\(UserDefaults.standard.object(forKey: UserDefaultsKey.username) as? String ?? "")SavedQuiz.plist"
    }
    
//    static public func getUserImage() -> UIImage {
//        return 
//    }
    
    static public func saveUserImage(newImage: Data) {
        userProfile.userImage = newImage
        save()
    }
    
    static public func getSavedQuizzes() -> UserInfo {
        let path = DataPersistenceManager.filepathToDocumentsDiretory(filename: getfilename()).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    userProfile = try PropertyListDecoder().decode(UserInfo.self, from: data)
                } catch {
                    print("property list decoding error getQuizzes - \(error)")
                }
            } else {
                print("getQuizzes - data is nil")
            }
        } else {
            print("\(getfilename()) - does not exist ")
        }
        //savedQuizzes = savedQuizzes.sorted{ $0.date > $1.date }
        return userProfile
    }
    
    static public func save() {
        let path = DataPersistenceManager.filepathToDocumentsDiretory(filename: getfilename())
        do {
            let data = try PropertyListEncoder().encode(userProfile)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding error at save(): \(error)")
        }
    }
    
    
    static public func add(newQuiz: SavedQuiz) {
        userProfile.savedQuiz.append(newQuiz)
        save()
    }
    
    static func delete(atIndex index: Int) {
        userProfile.savedQuiz.remove(at: index)
        save()
    }
    
    static public func isDuplicate(quizTitle: String) -> Bool {
        let index = getSavedQuizzes().savedQuiz.index { $0.quizTitle == quizTitle }
        var found = false
        if let _ = index {
            found = true
        }
        return found
    }
    
//    static public func deleteByQuizTitle(quizTitle: String) {
//        //not the most memory efficient way to do this, but it solves the problem for now
//        for (index, quiz) in savedQuizzes.enumerated() {
//            if quiz.quizTitle == quizTitle {
//                savedQuizzes.remove(at: index)
//            }
//        }
//        save()
//    }
}
