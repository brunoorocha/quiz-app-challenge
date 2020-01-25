//
//  HorizontalSeparator.swift
//  quiz-app
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import UIKit

class HorizontalSeparator: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }
    
    convenience init (height: CGFloat) {
        let frame = CGRect(origin: .zero, size: CGSize(width: 0, height: height))
        self.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customize () {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.rgba(0, 0, 0, 0.1)
        heightAnchor.constraint(equalToConstant: frame.height).isActive = true
    }
}
