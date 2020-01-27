//
//  QuestionServiceStub.swift
//  quiz-appTests
//
//  Created by Bruno Rocha on 27/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import Foundation
@testable import quiz_app

final class QuestionServiceStub: QuestionServiceProtocol {
    let mockResponse = QuizQuestion(question: "Mock question", answer: ["while", "for", "if"])
    var requestWasCaled = false

    func getQuestion(completionHandler: @escaping (Result<QuizQuestion, NetworkServiceError>) -> Void) {
        requestWasCaled = true
        completionHandler(.success(self.mockResponse))
    }
}
