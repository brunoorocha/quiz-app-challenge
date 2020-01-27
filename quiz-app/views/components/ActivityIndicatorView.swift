//
//  ActivityIndicatorView.swift
//  quiz-app
//
//  Created by Bruno Rocha on 26/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {
    let activityIndicator = ActivityIndicator(frame: .zero)
    let loadingLabel = LoadingLabel()

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
        layer.cornerRadius = 16
    }
    
    private func configureSubviews () {
        loadingLabel.text = "Loading..."

        addSubview(activityIndicator)
        addSubview(loadingLabel)
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8).isActive = true

        loadingLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 24).isActive = true
    }
}
