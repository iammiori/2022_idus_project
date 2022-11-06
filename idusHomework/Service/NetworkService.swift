//
//  NetworkService.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/12.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func fetchInfo<T>(_ resource: NetworkResource<T>) -> AnyPublisher<T, Error>
}
final class NetworkService: NetworkServiceProtocol {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    
    func fetchInfo<T>(_ resource: NetworkResource<T>) -> AnyPublisher<T, Error> {
        guard let request = resource.urlRequest else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }
        return session
            .dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode) else {
                    let response = result.response as? HTTPURLResponse
                    let statusCode = response?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: statusCode)
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
