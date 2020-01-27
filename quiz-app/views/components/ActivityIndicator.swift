//
//  ActivityIndicator.swift
//  quiz-app
//
//  Created by Bruno Rocha on 26/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import UIKit

class ActivityIndicator: UIActivityIndicatorView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customize () {
        translatesAutoresizingMaskIntoConstraints = false
        style = .large
        color = .white
        startAnimating()
        transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
    }
}
