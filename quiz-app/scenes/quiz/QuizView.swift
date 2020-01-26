//
//  QuizView.swift
//  quiz-app
//
//  Created by Bruno Rocha on 26/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import UIKit

class QuizView: UIView {
    let questionLabel = LargeTitle()
    let answerTextField = TextField()
    let quizFooterView = QuizFooterView()
    let loadingView = LoadingView()
    let playerAnswersTableView = UITableView()
    var quizFooterViewBottomConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureSubviews()
        configureKeyboardEventObservers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureKeyboardEventObservers () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureView () {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }
    
    private func configureSubviews () {
        playerAnswersTableView.keyboardDismissMode = .interactive
        playerAnswersTableView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(questionLabel)
        addSubview(answerTextField)
        addSubview(playerAnswersTableView)
        addSubview(quizFooterView)
        addSubview(loadingView)

        quizFooterViewBottomConstraint = quizFooterView.bottomAnchor.constraint(equalTo: bottomAnchor)

        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            answerTextField.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16),
            answerTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            answerTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            playerAnswersTableView.topAnchor.constraint(equalTo: answerTextField.bottomAnchor),
            playerAnswersTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            playerAnswersTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            playerAnswersTableView.bottomAnchor.constraint(equalTo: quizFooterView.topAnchor),

            quizFooterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            quizFooterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            quizFooterViewBottomConstraint,
            
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setQuizFooterViewBottomConstraintConstant(to constant: CGFloat) {
        quizFooterViewBottomConstraint.isActive = false
        quizFooterViewBottomConstraint = quizFooterView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: constant)
        quizFooterViewBottomConstraint.isActive = true

        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseOut], animations: { [weak self] in
            self?.layoutIfNeeded()
        })
    }

    func showLoadingView () {
        loadingView.isHidden = false
        questionLabel.isHidden = true
        answerTextField.isHidden = true
        playerAnswersTableView.isHidden = true
    }

    func hideLoadingView () {
        loadingView.isHidden = true
        questionLabel.isHidden = false
        answerTextField.isHidden = false
    }

    func alreadyHasAnswers () {
        playerAnswersTableView.isHidden = false
    }
    
    func hasNoAnswers () {
        playerAnswersTableView.isHidden = true
        playerAnswersTableView.reloadData()
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        setQuizFooterViewBottomConstraintConstant(to: -keyboardSize.size.height)
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        setQuizFooterViewBottomConstraintConstant(to: 0)
    }
}
