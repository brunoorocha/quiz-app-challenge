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

    func testTimeCountdownLabelFormat () {
        let viewModel = QuizViewModel(timeLimitInSeconds: 60)
        XCTAssertEqual(viewModel.timeCountdownLabelText, "01:00")
    }

}
