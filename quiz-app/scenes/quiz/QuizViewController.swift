//
//  QuizViewController.swift
//  quiz-app
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func bindToViewModel () {
        viewModel.matchWillStart = { [weak self] in
            self?.quizView.answerTextField.isEnabled = false
            self?.quizView.quizFooterView.button.setTitle(self?.viewModel.startResetButtonText, for: .normal)
        }
        
        viewModel.matchDidStart = { [weak self] in
            self?.quizView.answerTextField.isEnabled = true
            self?.quizView.answerTextField.becomeFirstResponder()
        }

        viewModel.matchIsReadyToStart = { [weak self] in
            self?.quizView.questionLabel.text = self?.viewModel.question
            self?.quizView.quizFooterView.countdownLabel.text = self?.viewModel.timeCountdownLabelText
            self?.quizView.quizFooterView.scoringLabel.text = self?.viewModel.scoringLabelText
        }

        viewModel.timeCountdowDidUpdate = { [weak self] in
            self?.quizView.quizFooterView.countdownLabel.text = self?.viewModel.timeCountdownLabelText
        }
        
//        viewModel.timeCountdowDidEnd = { [weak self] in
//
//        }
    }
    
    @objc private func didTapOnStartResetButton () {
        viewModel.onStartResetAction()
        self.quizView.quizFooterView.button.setTitle(self.viewModel.startResetButtonText, for: .normal)
    }
    */

}
