//
//  UserInfo.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/2/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct UserInfo: Codable {
    let username: String
    var userImage: Data?
    let savedQuiz: [SavedQuiz]?
}
