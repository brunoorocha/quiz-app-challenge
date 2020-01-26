//
//  QuizViewModelTests.swift
//  quiz-appTests
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import XCTest
@testable import quiz_app

class QuizViewModelTests: XCTestCase {
    override func setUp() {}
    override func tearDown() {}

    func testTimeCountdownLabel_shouldBeInRightFormat () {
        let viewModel = QuizViewModel(timeLimitInSeconds: 60)
        XCTAssertEqual(viewModel.timeCountdownLabelText, "01:00")
    }
    
    func testTimers_timeCountdownShouldBeEqualToTimeLimitWhenInitialized () {
        let viewModel = QuizViewModel(timeLimitInSeconds: 60)
        XCTAssertEqual(viewModel.timeCountdownInSeconds, viewModel.timeLimitInSeconds)
    }

    func testScoringLabelText_shouldBeInRightFormat_firstCase () {
        let viewModel = makeAMockQuizViewModel()
        XCTAssertEqual(viewModel.scoringLabelText, "00/03")
    }

    func testScoringLabelText_shouldBeInRightFormat_secondCase () {
        let viewModel = makeAMockQuizViewModel()
        viewModel.startMatch()
        viewModel.playerDidTypeAnAnswer(answer: "while")
        XCTAssertEqual(viewModel.scoringLabelText, "01/03")
    }

    func testPlayerTypedAnAnswer_shouldAddOnPlayerRightAnswersWhenItsRight () {
        let viewModel = makeAMockQuizViewModel()
        viewModel.startMatch()

        let answer = "for"
        viewModel.playerDidTypeAnAnswer(answer: answer)

        XCTAssertEqual(viewModel.numberOfPlayerRightAnswers, 1)
        XCTAssertTrue(viewModel.playerRightAnswers.contains(answer))
    }

    func testPlayerTypedAnAnswer_shouldAddOnPlayerRightAnswersJustOnceWhenItsRight () {
        let viewModel = makeAMockQuizViewModel()
        viewModel.startMatch()

        let answer = "for"
        viewModel.playerDidTypeAnAnswer(answer: answer)
        viewModel.playerDidTypeAnAnswer(answer: answer)
        
        let numberOfEqualAnswers = viewModel.playerRightAnswers.filter { $0 == answer }.count

        XCTAssertEqual(numberOfEqualAnswers, 1)
    }

    func testPlayerDidTypeAnAnswer_shouldNotAddOnPlayerRightAnswersWhenItsWrong () {
        let viewModel = makeAMockQuizViewModel()
        let answer = "forever"

        viewModel.playerDidTypeAnAnswer(answer: answer)

        XCTAssertEqual(viewModel.numberOfPlayerRightAnswers, 0)
        XCTAssertFalse(viewModel.playerRightAnswers.contains(answer))
    }

    func testPlayerDidTypeAnAnswer_shouldNotAcceptAnswersWhenMatchIsNotRunning () {
        let viewModel = makeAMockQuizViewModel()
        let answer = "for"
        let previousNumberOfRightAnswers = viewModel.numberOfPlayerRightAnswers

        viewModel.playerDidTypeAnAnswer(answer: answer)

        let currentNumberOfRightAnswers = viewModel.numberOfPlayerRightAnswers
        XCTAssertEqual(currentNumberOfRightAnswers, previousNumberOfRightAnswers)
    }
    
    func testPlayerRightAnswersViewModels_shouldHaveTheSameNumberOfPlayerRightAnswers () {
        var viewModel = makeAMockQuizViewModel()
        viewModel.playerDidTypeAnAnswer(answer: "for")
        viewModel.playerDidTypeAnAnswer(answer: "while")

        XCTAssertEqual(viewModel.playerRightAnswersViewModels.count, viewModel.numberOfPlayerRightAnswers)
    }
    
    func testPlayerRightAnswersViewModels_answerPropertyShouldHaveTheRightValue () {
        let viewModel = makeAMockQuizViewModel()
        viewModel.startMatch()

        let answer = "for"
        viewModel.playerDidTypeAnAnswer(answer: answer)

        XCTAssertEqual(viewModel.playerRightAnswersViewModels.last?.answer, answer)
    }
    
    func testStartResetButtonText_shouldInitWithStartValue () {
        let viewModel = QuizViewModel()
        XCTAssertEqual(viewModel.startResetButtonText, "Start")
    }

    func testStartResetButtonText_shouldHaveResetValueWhenMatchStarts () {
        let viewModel = QuizViewModel()
        viewModel.startMatch()
        XCTAssertEqual(viewModel.startResetButtonText, "Reset")
    }
    
    func testStartResetButtonText_shouldHaveStartValueWhenResetMatchMethodWasCalled () {
        let viewModel = QuizViewModel()
        viewModel.startMatch()
        viewModel.resetMatch()
        XCTAssertEqual(viewModel.startResetButtonText, "Start")
    }
    
    func testMatchState_shouldBeNotStartedWhenInit () {
        let viewModel = QuizViewModel()
        XCTAssertEqual(viewModel.matchState, .notStarted)
    }

    func testMatchState_shouldBeRunningWhenMatchStarts () {
        let viewModel = QuizViewModel()
        viewModel.startMatch()
        XCTAssertEqual(viewModel.matchState, .running)
    }

    func testMatchState_shouldBeWaitingToStartWhenMatchIsBeingPrepared () {
        let viewModel = QuizViewModel()
        viewModel.prepareMatchToStart()
        XCTAssertEqual(viewModel.matchState, .waitingToStart)
    }

    func testMatchState_shouldBeEndedWhenMatchEnds () {
        let viewModel = QuizViewModel()
        viewModel.startMatch()
        viewModel.endMatch()
        XCTAssertEqual(viewModel.matchState, .finished)
    }

    private func makeAMockQuizViewModel () -> QuizViewModel {
        var viewModel = QuizViewModel()
        viewModel.possibleAnswers = ["while", "for", "if"]
        viewModel.playerRightAnswers = []
        return viewModel
    }
}
