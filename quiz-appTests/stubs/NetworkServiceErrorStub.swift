//
//  NetworkServiceErrorStub.swift
//  quiz-appTests
//
//  Created by Bruno Rocha on 27/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import Foundation
@testable import quiz_app

class NetworkServiceErrorStub: NetworkServiceProtocol {
    func request<T>(resource: Resource, completionHandler: @escaping (Result<T?, NetworkServiceError>) -> Void) where T : Decodable {
        completionHandler(.failure(.resourceNotFount))
    }
}
