//
//  QuizFooterView.swift
//  quiz-app
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import UIKit

class QuizFooterView: UIView {
    let wordCounterLabel = LabelLarge()
    let countdownLabel = LabelLarge()
    let button = Button()
    private var separator = HorizontalSeparator(height: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customize () {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.rgba(245, 245, 245)
    }
    
    private func configureSubviews () {
        wordCounterLabel.text = "00/50"
        countdownLabel.text = "05:00"
        button.setTitle("Start", for: .normal)

        addSubview(separator)
        addSubview(wordCounterLabel)
        addSubview(countdownLabel)
        addSubview(button)
        
        separator.topAnchor.constraint(equalTo: topAnchor).isActive = true
        separator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        wordCounterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        wordCounterLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true

        countdownLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        countdownLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true

        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.topAnchor.constraint(equalTo: wordCounterLabel.bottomAnchor, constant: 16).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true

        bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 16).isActive = true
    }
}
