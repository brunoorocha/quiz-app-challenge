//
//  UIViewController+presentAlertController.swift
//  quiz-app
//
//  Created by Bruno Rocha on 26/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlertController (withTitle title: String, message: String, andActionTitle actionTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
