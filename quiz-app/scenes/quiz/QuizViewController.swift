//
//  QuizViewController.swift
//  quiz-app
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    let quizView = QuizView()
    let viewModel = QuizViewModel(service: QuestionService())

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        configureEventHandlers()
        configureDelegatesAndDataSources()
        viewModel.prepareMatchToStart()
    }

    override func loadView() {
        view = quizView
    }

    private func configureDelegatesAndDataSources () {
        quizView.answerTextField.delegate = self
        quizView.playerAnswersTableView.dataSource = self
    }
    
    private func configureEventHandlers () {
        quizView.quizFooterView.button.addTarget(self, action: #selector(didTapOnStartResetButton), for: .touchUpInside)
    }
    
    private func bindToViewModel () {
        viewModel.matchWillStart = { [weak self] in
            self?.quizView.hasNoAnswers()
            self?.quizView.showLoadingView()
            self?.quizView.answerTextField.placeholder = self?.viewModel.answerTextFieldPlaceholder
            self?.quizView.quizFooterView.button.setTitle(self?.viewModel.startResetButtonText, for: .normal)
        }

        viewModel.matchIsReadyToStart = { [weak self] in
            self?.quizView.hasNoAnswers()
            self?.quizView.hideLoadingView()
            self?.quizView.questionLabel.text = self?.viewModel.question
            self?.quizView.quizFooterView.countdownLabel.text = self?.viewModel.timeCountdownLabelText
            self?.quizView.quizFooterView.scoringLabel.text = self?.viewModel.scoringLabelText
        }

        viewModel.matchDidStart = { [weak self] in
            self?.quizView.answerTextField.becomeFirstResponder()
        }

        viewModel.timeCountdowDidUpdate = { [weak self] in
            self?.quizView.quizFooterView.countdownLabel.text = self?.viewModel.timeCountdownLabelText
        }

        viewModel.playerDidHitAnKeyword = { [weak self] in
            self?.addAnswerTableViewCell()
            self?.quizView.quizFooterView.scoringLabel.text = self?.viewModel.scoringLabelText
            self?.quizView.answerTextField.text = ""
            if let hasAnswers = self?.viewModel.playerRightAnswers.count, hasAnswers > 0 {
                self?.quizView.alreadyHasAnswers()
            }
        }

        viewModel.matchDidEnd = { [weak self] in
            self?.quizView.answerTextField.resignFirstResponder()
            self?.quizView.answerTextField.text = ""
            self?.showMatchEndAlert()
        }
        
        viewModel.onError = { [weak self] error in
            self?.showErrorAlert(errorDescription: error.localizedDescription)
        }
    }

    private func addAnswerTableViewCell () {
        let row = viewModel.playerRightAnswersViewModels.count - 1
        let newCellIndexPath = IndexPath(row: row, section: 0)
        quizView.playerAnswersTableView.beginUpdates()
        quizView.playerAnswersTableView.insertRows(at: [newCellIndexPath], with: .top)
        quizView.playerAnswersTableView.endUpdates()
        quizView.playerAnswersTableView.scrollToRow(at: newCellIndexPath, at: .bottom, animated: true)
    }
    
    private func playerWantToCheckAnAnswer () {
        guard let typedAnswer = quizView.answerTextField.text, !typedAnswer.isEmpty else { return }
        viewModel.playerDidTypedAnAnswer(answer: typedAnswer)
    }
    
    private func showMatchEndAlert () {
        presentAlertController(
            withTitle: viewModel.matchEndAlertViewModel.title,
            message: viewModel.matchEndAlertViewModel.message,
            andActionTitle: viewModel.matchEndAlertViewModel.actionTitle
        )
    }
    
    private func showErrorAlert (errorDescription: String) {
        presentAlertController(withTitle: "Something's wrong", message: errorDescription, andActionTitle: "Ok")
    }
    
    @objc private func didTapOnStartResetButton () {
        viewModel.onStartResetAction()
        self.quizView.quizFooterView.button.setTitle(self.viewModel.startResetButtonText, for: .normal)
    }    
}

extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.playerRightAnswersViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let cellViewModel = viewModel.playerRightAnswersViewModels[indexPath.row]
        cell.textLabel?.text = cellViewModel.answer
        return cell
    }
}

extension QuizViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        playerWantToCheckAnAnswer()
        return true
    }
>>>>>>> Implemented the player right answers table view with methods to add the new keywords.
}
