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
    var answerTextFieldPlaceholder: String = "Insert Word"
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

    var playerDidWin: Bool {
        return numberOfPlayerRightAnswers == numberOfPossibleAnswers
    }

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
        return matchState == .running || matchState == .finished ? "Reset" : "Start"
    }
    
    var playerRightAnswersViewModels: [AnswerViewModel] {
        return playerRightAnswers.map { AnswerViewModel(answer: $0) }
    }
    
    var matchEndAlertViewModel: MatchEndAlerViewModel {
        if (playerDidWin) {
            return MatchEndAlerViewModel(
                title: "Congratulations",
                message: "Good job! You found all the answers on time. Keep up with the great work.",
                actionTitle: "Play again"
            )
        }

        let message = String(format: "Sorry, time is up! You got %d out of %d answers", numberOfPlayerRightAnswers, numberOfPossibleAnswers)
        return MatchEndAlerViewModel(title: "Time finished", message: message, actionTitle: "Try Again")
    }
    
    var service: QuestionServiceProtocol

    init (service: QuestionServiceProtocol, timeLimitInSeconds: TimeInterval = 300) {
        self.timeLimitInSeconds = timeLimitInSeconds
        self.service = service
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
    
    func playerDidTypedAnAnswer(answer: String) {
        if (matchState != .running) { return }

        let isPlayerAnswerRight = possibleAnswers.first { $0 == answer.lowercased() } != nil
        let answerHasAlreadyBeenCounted = playerRightAnswers.contains(answer)
        if (isPlayerAnswerRight && !answerHasAlreadyBeenCounted) {
            playerRightAnswers.append(answer)
            playerDidHitAnKeyword?()

            if (playerDidWin) {
                endMatch()
            }
        }
    }
    
    func onStartResetAction () {
        if (matchState == .running || matchState == .finished) {
            resetMatch()
            return
        }

        startMatch()
    }

    func prepareMatchToStart () {
        matchState = .waitingToStart
        matchWillStart?()

        service.getQuestion { [weak self] (result: Result<QuizQuestion, Error>) in
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
        timer.pause()
        matchDidEnd?()
    }
    
    func resetMatch () {
        matchState = .notStarted
        timer.reset()
        playerRightAnswers = []
        matchIsReadyToStart?()
    }

    func updateTimeCountdown (_ value: TimeInterval) {
        timeCountdownInSeconds = value
        timeCountdowDidUpdate?()
    }
    
    func timedOut () {
        endMatch()
        timeCountdowDidEnd?()
    }
}

