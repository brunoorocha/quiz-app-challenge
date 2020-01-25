//
//  QuestionUseCases.swift
//  quiz-app
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import Foundation

protocol QuestionUseCasesProtocol {
    func getQuestion (completionHandler: @escaping (Result<QuizQuestion, Error>) -> Void)
}

final class QuestionUseCases: QuestionUseCasesProtocol {
    let networkService: NetworkServiceProtocol!
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getQuestion(completionHandler: @escaping (Result<QuizQuestion, Error>) -> Void) {
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

