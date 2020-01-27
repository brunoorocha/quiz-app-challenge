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
        let viewModel = QuizViewModel(service: QuestionService(), timeLimitInSeconds: 60)
        XCTAssertEqual(viewModel.timeCountdownLabelText, "01:00")
    }
    
    func testTimers_timeCountdownShouldBeEqualToTimeLimitWhenInitialized () {
        let viewModel = QuizViewModel(service: QuestionService(), timeLimitInSeconds: 60)
        XCTAssertEqual(viewModel.timeCountdownInSeconds, viewModel.timeLimitInSeconds)
    }

    func testScoringLabelText_shouldBeInRightFormat_firstCase () {
        let viewModel = makeAMockQuizViewModel()
        XCTAssertEqual(viewModel.scoringLabelText, "00/03")
    }

    func testScoringLabelText_shouldBeInRightFormat_secondCase () {
        let viewModel = makeAMockQuizViewModel()
        viewModel.startMatch()
        viewModel.playerDidTypedAnAnswer(answer: "while")
        XCTAssertEqual(viewModel.scoringLabelText, "01/03")
    }

    func testPlayerTypedAnAnswer_shouldAddOnPlayerRightAnswersWhenItsRight () {
        let viewModel = makeAMockQuizViewModel()
        viewModel.startMatch()

        let answer = "for"
        viewModel.playerDidTypedAnAnswer(answer: answer)

        XCTAssertEqual(viewModel.numberOfPlayerRightAnswers, 1)
        XCTAssertTrue(viewModel.playerRightAnswers.contains(answer))
    }

    func testPlayerTypedAnAnswer_shouldAddOnPlayerRightAnswersJustOnceWhenItsRight () {
        let viewModel = makeAMockQuizViewModel()
        viewModel.startMatch()

        let answer = "for"
        viewModel.playerDidTypedAnAnswer(answer: answer)
        viewModel.playerDidTypedAnAnswer(answer: answer)
        
        let numberOfEqualAnswers = viewModel.playerRightAnswers.filter { $0 == answer }.count

        XCTAssertEqual(numberOfEqualAnswers, 1)
    }

    func testPlayerDidTypeAnAnswer_shouldNotAddOnPlayerRightAnswersWhenItsWrong () {
        let viewModel = makeAMockQuizViewModel()
        let answer = "forever"

        viewModel.playerDidTypedAnAnswer(answer: answer)

        XCTAssertEqual(viewModel.numberOfPlayerRightAnswers, 0)
        XCTAssertFalse(viewModel.playerRightAnswers.contains(answer))
    }

    func testPlayerDidTypeAnAnswer_shouldNotAcceptAnswersWhenMatchIsNotRunning () {
        let viewModel = makeAMockQuizViewModel()
        let answer = "for"
        let previousNumberOfRightAnswers = viewModel.numberOfPlayerRightAnswers

        viewModel.playerDidTypedAnAnswer(answer: answer)

        let currentNumberOfRightAnswers = viewModel.numberOfPlayerRightAnswers
        XCTAssertEqual(currentNumberOfRightAnswers, previousNumberOfRightAnswers)
    }
    
    func testPlayerRightAnswersViewModels_shouldHaveTheSameNumberOfPlayerRightAnswers () {
<<<<<<< HEAD
        var viewModel = makeAMockQuizViewModel()
        viewModel.playerDidTypeAnAnswer(answer: "for")
        viewModel.playerDidTypeAnAnswer(answer: "while")
=======
        let viewModel = makeAMockQuizViewModel()
        viewModel.playerDidTypedAnAnswer(answer: "for")
        viewModel.playerDidTypedAnAnswer(answer: "while")
>>>>>>> Make some refactoring to make the code more clearer and using dependency injection to set the service used on QuizViewModel

        XCTAssertEqual(viewModel.playerRightAnswersViewModels.count, viewModel.numberOfPlayerRightAnswers)
    }
    
    func testPlayerRightAnswersViewModels_answerPropertyShouldHaveTheRightValue () {
        let viewModel = makeAMockQuizViewModel()
        viewModel.startMatch()

        let answer = "for"
        viewModel.playerDidTypedAnAnswer(answer: answer)

        XCTAssertEqual(viewModel.playerRightAnswersViewModels.last?.answer, answer)
    }
    
    func testStartResetButtonText_shouldInitWithStartValue () {
        let viewModel = QuizViewModel(service: QuestionService())
        XCTAssertEqual(viewModel.startResetButtonText, "Start")
    }

    func testStartResetButtonText_shouldHaveResetValueWhenMatchStarts () {
        let viewModel = QuizViewModel(service: QuestionService())
        viewModel.startMatch()
        XCTAssertEqual(viewModel.startResetButtonText, "Reset")
    }
    
    func testStartResetButtonText_shouldHaveStartValueWhenResetMatchMethodWasCalled () {
        let viewModel = QuizViewModel(service: QuestionService())
        viewModel.startMatch()
        viewModel.resetMatch()
        XCTAssertEqual(viewModel.startResetButtonText, "Start")
    }
    
    func testMatchState_shouldBeNotStartedWhenInit () {
        let viewModel = QuizViewModel(service: QuestionService())
        XCTAssertEqual(viewModel.matchState, .notStarted)
    }

    func testMatchState_shouldBeRunningWhenMatchStarts () {
        let viewModel = QuizViewModel(service: QuestionService())
        viewModel.startMatch()
        XCTAssertEqual(viewModel.matchState, .running)
    }

    func testMatchState_shouldBeWaitingToStartWhenMatchIsBeingPrepared () {
        let viewModel = QuizViewModel(service: QuestionService())
        viewModel.prepareMatchToStart()
        XCTAssertEqual(viewModel.matchState, .waitingToStart)
    }

    func testMatchState_shouldBeEndedWhenMatchEnds () {
        let viewModel = QuizViewModel(service: QuestionService())
        viewModel.startMatch()
        viewModel.endMatch()
        XCTAssertEqual(viewModel.matchState, .finished)
    }

    private func makeAMockQuizViewModel () -> QuizViewModel {
<<<<<<< HEAD
        var viewModel = QuizViewModel()
=======
        let viewModel = QuizViewModel(service: QuestionService())
>>>>>>> Make some refactoring to make the code more clearer and using dependency injection to set the service used on QuizViewModel
        viewModel.possibleAnswers = ["while", "for", "if"]
        viewModel.playerRightAnswers = []
        return viewModel
    }
}
