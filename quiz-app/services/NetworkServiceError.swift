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
    
    var localizedDescription: String {
        switch self {
        case .invalidUrl, .resourceNotFount:
            return "We're sorry, but an internal error occurred and we couldn't find our servers."
        case .serverError:
            return "We're sorry, a problem occurred with our servers."
        case .connectionCancelled, .noInternetConnection:
            return "We're sorry, we couldn't reach out our servers. Please check out your internet connection."
        case .failureOnDecode, .unknown:
            return "We're sorry, an internal error occurred and we couldn't create a match."
        }
    }
}
