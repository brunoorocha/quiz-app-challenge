//
//  QuestionService.swift
//  quiz-app
//
//  Created by Bruno Rocha on 26/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import Foundation

protocol QuestionServiceProtocol {
    func getQuestion (completionHandler: @escaping (Result<QuizQuestion, NetworkServiceError>) -> Void)
}

final class QuestionService: QuestionServiceProtocol {
    let networkService: NetworkServiceProtocol!
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getQuestion(completionHandler: @escaping (Result<QuizQuestion, NetworkServiceError>) -> Void) {
        let questionResource = Resource(endpoint: "https://codechallenge.arctouch.com/quiz/1", httpMethod: .get)
        networkService.request(resource: questionResource) { (result: Result<QuizQuestion?, NetworkServiceError>) in
            switch result {
            case .success(let question):
                guard let question = question else { return }
                completionHandler(.success(question))
                
            case .failure(let error):
                completionHandler(.failure(error))
                return
            }
        }
    }
}
