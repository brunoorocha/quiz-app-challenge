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
        bindToViewModel()
        configureEventHandlers()
        configureDelegatesAndDataSources()
        viewModel.prepareMatchToStart()
    }

    override func loadView() {
        view = quizView
    }
    
    private func configureDelegatesAndDataSources () {
        quizView.playerAnswersTableView.delegate = self
        quizView.playerAnswersTableView.dataSource = self
        quizView.answerTextField.delegate = self
    }
    
    private func configureEventHandlers () {
        quizView.quizFooterView.button.addTarget(self, action: #selector(didTapOnStartResetButton), for: .touchUpInside)
    }
    
    private func bindToViewModel () {
        viewModel.matchWillStart = { [weak self] in
            self?.quizView.answerTextField.isEnabled = false
            self?.quizView.answerTextField.placeholder = self?.viewModel.answerTextFieldPlaceholder
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
        
        viewModel.playerDidHitAnKeyword = { [weak self] in
            self?.addAnswerTableViewCell()
            self?.quizView.quizFooterView.scoringLabel.text = self?.viewModel.scoringLabelText
        }
        
        viewModel.timeCountdowDidEnd = { [weak self] in
            self?.quizView.answerTextField.resignFirstResponder()
            self?.quizView.answerTextField.isEnabled = false
            self?.quizView.answerTextField.text = ""
        }
    }
    
    @objc private func didTapOnStartResetButton () {
        viewModel.onStartResetAction()
        self.quizView.quizFooterView.button.setTitle(self.viewModel.startResetButtonText, for: .normal)
    }
<<<<<<< HEAD
    */

=======
    
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
        viewModel.playerDidTypeAnAnswer(answer: typedAnswer)
        self.quizView.answerTextField.text = ""
    }
}

extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
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
