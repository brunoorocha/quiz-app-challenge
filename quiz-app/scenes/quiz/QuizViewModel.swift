//
//  QuizViewModel.swift
//  quiz-app
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import Foundation

enum MatchState {
    case waitingToStart
    case running
    case over
}

struct QuizViewModel {
    var question: String
    var possibleAnswers: [String]
    var playerRightAnswers: [String]

    var playerRightAnswersCount: Int {
        return playerRightAnswers.count
    }
    
    var timeLimit: TimeInterval
    var timeCountdown: TimeInterval
    
    var matchState: MatchState
}

