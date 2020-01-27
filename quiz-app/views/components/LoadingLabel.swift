//
//  LoadingLabel.swift
//  quiz-app
//
//  Created by Bruno Rocha on 26/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import UIKit

class LoadingLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func customize () {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 17, weight: .bold)
        textColor = .white
        numberOfLines = 0
        sizeToFit()
    }
}

