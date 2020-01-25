//
//  NetworkService.swift
//  quiz-app
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable> (resource: Resource, completionHandler: @escaping (Result<T?, NetworkServiceError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    private var task: URLSessionTask!

    func request<T: Decodable>(resource: Resource, completionHandler: @escaping (Result<T?, NetworkServiceError>) -> Void) {
        let urlSession = URLSession.shared

        guard let resourceUrl = URL(string: resource.endpoint) else {
            completionHandler(.failure(.invalidUrl))
            return
        }

        var request = URLRequest(url: resourceUrl)
        request.httpMethod = resource.httpMethod.rawValue
        
        self.task = urlSession.dataTask(with: request) { responseData, response, error in
            if let error = error {
                var networkServiceError: NetworkServiceError
                
                if let errorResponse = response as? HTTPURLResponse, (400..<600).contains(errorResponse.statusCode) {
                    networkServiceError = .serverError
                }
                else if (error._code == NSURLErrorNotConnectedToInternet) {
                    networkServiceError = .noInternetConnection
                } else if (error._code == NSURLErrorCancelled) {
                    networkServiceError = .connectionCancelled
                } else {
                    networkServiceError = .unknown
                }

                DispatchQueue.main.async {
                    completionHandler(.failure(networkServiceError))
                    return
                }
            }

            do {
                guard let responseData = responseData else {
                    completionHandler(.success(nil))
                    return
                }
                
                let decodedResponseData = try JSONDecoder().decode(T.self, from: responseData)
                DispatchQueue.main.async {
                    completionHandler(.success(decodedResponseData))
                    return
                }
            }
            catch let error {
                #if DEBUG
                print(error)
                #endif

                DispatchQueue.main.async {
                    completionHandler(.failure(.failureOnDecode))
                }
            }
        }

        self.task.resume()
    }
}

