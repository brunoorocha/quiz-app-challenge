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
    let playerAnswersTableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            answerTextField.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16),
            answerTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            answerTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            playerAnswersTableView.topAnchor.constraint(equalTo: answerTextField.bottomAnchor, constant: 16),
            playerAnswersTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerAnswersTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerAnswersTableView.bottomAnchor.constraint(equalTo: quizFooterView.topAnchor),

            quizFooterView.bottomAnchor.constraint(equalTo: bottomAnchor),
            quizFooterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            quizFooterView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
