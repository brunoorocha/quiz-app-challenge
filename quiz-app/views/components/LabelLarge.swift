//
//  LabelLarge.swift
//  quiz-app
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import UIKit

class LabelLarge: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func customize () {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 34, weight: .bold)
        numberOfLines = 0
        sizeToFit()
    }
}
