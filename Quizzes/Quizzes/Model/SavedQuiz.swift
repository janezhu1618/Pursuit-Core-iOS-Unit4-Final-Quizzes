//
//  SavedQuiz.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct SavedQuiz: Codable {
    let quizTitle: String
    let facts: [String]
    var addedDate: String
    public var date: Date {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = Date()
            if let date = isoDateFormatter.date(from: addedDate) {
                formattedDate = date
            }
        return formattedDate
    }
}