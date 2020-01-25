//
//  NetworkServiceError.swift
//  quiz-app
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import Foundation

enum NetworkServiceError: Error {
    case invalidUrl
    case noInternetConnection
    case connectionCancelled
    case resourceNotFount
    case serverError
    case failureOnDecode
    case unknown
}
