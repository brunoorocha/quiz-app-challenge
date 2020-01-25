//
//  QuizQuestion.swift
//  quiz-app
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import Foundation

struct QuizQuestion {
    var question: String
    var answer: [String]
}

extension QuizQuestion: Decodable {}
