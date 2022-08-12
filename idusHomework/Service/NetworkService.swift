//
//  NetworkService.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/12.
//

import Foundation
import Combine

final class NetworkService {
    let session: URLSession


    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    
    func fetchInfo(appID: Int) -> AnyPublisher<AppStoreResponse, Error> {
        //872469884
        let url = URL(string: "\(URLConstant.appstoreSarchQueryID)\(appID)")!

        let publisher = session
            .dataTaskPublisher(for: url)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode) else {
                    
                    let response = result.response as? HTTPURLResponse
                    let statusCode = response?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: statusCode)
                }
                return result.data
            }
            .decode(type: AppStoreResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher() 
        return publisher
    }
}
