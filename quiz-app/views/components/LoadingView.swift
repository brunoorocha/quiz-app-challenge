//
//  LoadingView.swift
//  quiz-app
//
//  Created by Bruno Rocha on 26/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import UIKit

class LoadingView: UIView {
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
        backgroundColor = UIColor.rgba(0, 0, 0, 0.6)
    }

    private func configureSubviews () {
        let activityIndicatorContainer = ActivityIndicatorView()
        addSubview(activityIndicatorContainer)

        activityIndicatorContainer.widthAnchor.constraint(equalToConstant: 200).isActive = true
        activityIndicatorContainer.heightAnchor.constraint(equalToConstant: 160).isActive = true
        activityIndicatorContainer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorContainer.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
