//
//  QuizAPIClient.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

final class QuizAPIClient {
    private init() { }
    static func getQuizzes(completionHandler: @escaping (AppError?, [Quiz]?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: "http://5c4d4c0d0de08100147c59b5.mockapi.io/api/v1/quizzes", httpMethod: "GET", httpBody: nil) { (appError, data) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            if let data = data {
                do {
                    let quizData = try JSONDecoder().decode([Quiz].self, from: data)
                    completionHandler(nil, quizData)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
        }
    }
}
