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

    func testScoringLabelText_shouldBeInRightFormat_firstCase () {
        let viewModel = makeAMockQuizViewModel()
        XCTAssertEqual(viewModel.scoringLabelText, "00/03")
    }

    func testScoringLabelText_shouldBeInRightFormat_secondCase () {
        var viewModel = makeAMockQuizViewModel()
        viewModel.playerDidTypeAnAnswer(answer: "while")
        XCTAssertEqual(viewModel.scoringLabelText, "01/03")
    }

    func testPlayerTypedAnAnswer_shouldAddOnPlayerRightAnswersWhenItsRight () {
        var viewModel = makeAMockQuizViewModel()
        let answer = "for"

        viewModel.playerDidTypeAnAnswer(answer: answer)

        XCTAssertEqual(viewModel.numberOfPlayerRightAnswers, 1)
        XCTAssertTrue(viewModel.playerRightAnswers.contains(answer))
    }

    func testPlayerTypedAnAnswer_shouldNotAddOnPlayerRightAnswersWhenItsWrong () {
        var viewModel = makeAMockQuizViewModel()
        let answer = "forever"

        viewModel.playerDidTypeAnAnswer(answer: answer)

        XCTAssertEqual(viewModel.numberOfPlayerRightAnswers, 0)
        XCTAssertFalse(viewModel.playerRightAnswers.contains(answer))
    }
    
    func testPlayerRightAnswersViewModels_shouldHaveTheSameNumberOfPlayerRightAnswers () {
        var viewModel = makeAMockQuizViewModel()
        viewModel.playerDidTypeAnAnswer(answer: "for")
        viewModel.playerDidTypeAnAnswer(answer: "while")

        XCTAssertEqual(viewModel.playerRightAnswersViewModels.count, viewModel.numberOfPlayerRightAnswers)
    }
    
    func testPlayerRightAnswersViewModels_answerPropertyShouldHaveTheRightValue () {
        var viewModel = makeAMockQuizViewModel()
        let answer = "for"
        viewModel.playerDidTypeAnAnswer(answer: answer)

        XCTAssertEqual(viewModel.playerRightAnswersViewModels.last?.answer, answer)
    }
    
    private func makeAMockQuizViewModel () -> QuizViewModel {
        var viewModel = QuizViewModel()
        viewModel.possibleAnswers = ["while", "for", "if"]
        viewModel.playerRightAnswers = []
        return viewModel
    }
}
