//
//  QuizViewModel.swift
//  quiz-app
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import Foundation

enum MatchState {
    case initial
    case waitingToStart
    case running
    case over
}

struct QuizViewModel {
    var question: String = ""
    var possibleAnswers: [String] = []
    var playerRightAnswers: [String] = []

    var playerRightAnswersCount: Int {
        return playerRightAnswers.count
    }
    
    let timeLimitInSeconds: TimeInterval
    var timeCountdownInSeconds: TimeInterval
    
    var matchState: MatchState = .initial
    
    var timeCountdownLabelText: String {
        let minutes = Int(timeCountdownInSeconds / 60)
        let seconds = Int(timeCountdownInSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    init (timeLimitInSeconds: TimeInterval = 10) {
        self.timeLimitInSeconds = timeLimitInSeconds
        timeCountdownInSeconds = timeLimitInSeconds
    }
}

