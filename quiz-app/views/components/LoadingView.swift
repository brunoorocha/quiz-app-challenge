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
        let activityIndicatorContainer: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.rgba(0, 0, 0, 0.6)
            view.layer.cornerRadius = 16
            return view
        }()

        let loadingLabel: UILabel = {
            let label = UILabel()
            label.text = "Loading..."
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            label.textColor = .white
            label.numberOfLines = 0
            label.sizeToFit()
            return label
        }()

        let activityIndicator: UIActivityIndicatorView = {
            let view = UIActivityIndicatorView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.style = .large
            view.color = .white
            view.startAnimating()
            view.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            return view
        }()

        activityIndicatorContainer.addSubview(activityIndicator)
        activityIndicatorContainer.addSubview(loadingLabel)
        addSubview(activityIndicatorContainer)

        activityIndicatorContainer.widthAnchor.constraint(equalToConstant: 200).isActive = true
        activityIndicatorContainer.heightAnchor.constraint(equalToConstant: 160).isActive = true
        activityIndicatorContainer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorContainer.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainer.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainer.centerYAnchor, constant: -loadingLabel.frame.height).isActive = true

        loadingLabel.centerXAnchor.constraint(equalTo: activityIndicatorContainer.centerXAnchor).isActive = true
        loadingLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 32).isActive = true
    }
}
