//
//  ViewController.swift
//  quiz-app
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let footerView = QuizFooterView()
        let viewModel = QuizViewModel()
        viewModel.prepareMatchToStart()

        view.addSubview(footerView)

        footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        viewModel.timeCountdowDidUpdate = {
            footerView.countdownLabel.text = viewModel.timeCountdownLabelText
        }
    }
}

