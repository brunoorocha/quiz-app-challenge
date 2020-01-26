//
//  QuizViewModel.swift
//  quiz-app
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import Foundation

enum MatchState {
    case notStarted
    case waitingToStart
    case running
    case finished
}

class QuizViewModel {
    var question: String = ""
    var possibleAnswers: [String] = []
    var playerRightAnswers: [String] = []

    let timeLimitInSeconds: TimeInterval
    var timeCountdownInSeconds: TimeInterval
    var timer: TimeCountdown
    
    var matchState: MatchState = .notStarted
    
    var timeCountdowDidUpdate: (() -> Void)?
    var timeCountdowDidEnd: (() -> Void)?
    var matchWillStart: (() -> Void)?
    var matchIsReadyToStart: (() -> Void)?
    var matchDidStart: (() -> Void)?
    var matchDidEnd: (() -> Void)?
    var playerDidHitAnKeyword: (() -> Void)?

    var numberOfPossibleAnswers: Int {
        return possibleAnswers.count
    }

    var numberOfPlayerRightAnswers: Int {
        return playerRightAnswers.count
    }
    
    var timeCountdownLabelText: String {
        let minutes = Int(timeCountdownInSeconds / 60)
        let seconds = Int(timeCountdownInSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var scoringLabelText: String {
        return String(format: "%02d/%02d", numberOfPlayerRightAnswers, numberOfPossibleAnswers)
    }
    
    var startResetButtonText: String {
        return self.matchState == .running ? "Reset" : "Start"
    }
    
    var playerRightAnswersViewModels: [AnswerViewModel] {
        return playerRightAnswers.map { AnswerViewModel(answer: $0) }
    }

    init (timeLimitInSeconds: TimeInterval = 60) {
        self.timeLimitInSeconds = timeLimitInSeconds
        timeCountdownInSeconds = timeLimitInSeconds
        timer = TimeCountdown(durationInSeconds: timeLimitInSeconds)
        bindToTimerEvents()
    }
    
    private func bindToTimerEvents () {
        timer.timerDidUpdate = { [weak self] countdownValue in
            self?.updateTimeCountdown(countdownValue)
        }

        timer.timerDidEnd = { [weak self] in
            self?.timedOut()
        }
    }
    
    func playerDidTypeAnAnswer(answer: String) {
        let isPlayerAnswerRight = possibleAnswers.first { $0 == answer.lowercased() } != nil
        let answerHasAlreadyBeenCounted = playerRightAnswers.contains(answer)
        if (isPlayerAnswerRight && !answerHasAlreadyBeenCounted) {
            playerRightAnswers.append(answer)
            playerDidHitAnKeyword?()
        }
    }
    
    func onStartResetAction () {
        if (matchState == .running) {
            resetMatch()
            return
        }

        startMatch()
    }

    func prepareMatchToStart () {
        matchState = .waitingToStart
        matchWillStart?()
        
        let useCase = QuestionUseCases(networkService: NetworkService())
        useCase.getQuestion { [weak self] (result: Result<QuizQuestion, Error>) in
            switch result {
            case .success(let quiz):
                self?.question = quiz.question
                self?.possibleAnswers = quiz.answer
                self?.startMatch()
            case .failure(let error):
                
                return
            }
        }
    }

    func startMatch () {
        matchState = .running
        timer.start()
        matchDidStart?()
    }

    func endMatch () {
        matchState = .finished
        matchDidEnd?()
    }
    
    func resetMatch () {
        matchState = .notStarted
        timer.reset()
        playerRightAnswers = []
    }

    func updateTimeCountdown (_ value: TimeInterval) {
        timeCountdownInSeconds = value
        timeCountdowDidUpdate?()
    }
    
    func timedOut () {
        timeCountdowDidEnd?()
    }
}

