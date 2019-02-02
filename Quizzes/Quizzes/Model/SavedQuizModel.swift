//
//  SavedQuizModel.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct SavedQuizModel {
    static var username = ""
    static let filename = "\(username)SaveQuiz.plist"
    static var savedQuizzes = [SavedQuiz]()
    
    static public func getSavedQuizzes() -> [SavedQuiz] {
        let path = DataPersistenceManager.filepathToDocumentsDiretory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    savedQuizzes = try PropertyListDecoder().decode([SavedQuiz].self, from: data)
                } catch {
                    print("property list decoding error getBooks - \(error)")
                }
            } else {
                print("getQuizzes - data is nil")
            }
        } else {
            print("\(filename) - does not exist ")
        }
        savedQuizzes = savedQuizzes.sorted{ $0.date > $1.date }
        return savedQuizzes
    }
    
    static public func save() {
        let path = DataPersistenceManager.filepathToDocumentsDiretory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(savedQuizzes)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding error at save(): \(error)")
        }
    }
    
    
    static public func add(newQuiz: SavedQuiz) {
        savedQuizzes.append(newQuiz)
        save()
    }
    
    static func delete(atIndex index: Int) {
        savedQuizzes.remove(at: index)
        save()
    }
    
    static public func isDuplicate(quizTitle: String) -> Bool {
        let index = getSavedQuizzes().index { $0.quizTitle == quizTitle }
        var found = false
        if let _ = index {
            found = true
        }
        return found
    }
}
