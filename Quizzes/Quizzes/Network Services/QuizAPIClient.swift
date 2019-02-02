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
        NetworkHelper.shared.performDataTask(endpointURLString: "https://quizzes-9ff59.firebaseio.com/.json", httpMethod: "GET", httpBody: nil) { (appError, data) in
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
