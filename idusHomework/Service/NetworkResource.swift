//
//  NetworkResource.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/13.
//

import Foundation

struct NetworkResource<T: Decodable> {
    var scheme: String
    var host: String
    var path: String
    var params: [String: String]
    var header: [String: String]
    var httpMethod: String
    
    private func getURLComponents() -> URLComponents {
        let queryItems = params.map { (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        }
        var urlComponets = URLComponents()
        urlComponets.scheme = scheme
        urlComponets.host = host
        urlComponets.path = path
        urlComponets.queryItems = queryItems
        return urlComponets
    }
    
    var urlRequest: URLRequest? {
        if let url = getURLComponents().url {
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod
            header.forEach { (key: String, value: String) in
                request.addValue(value, forHTTPHeaderField: key)
            }
            return request
        } else {
            return nil
        }
    }
    
    init(scheme: String, host: String, path: String, params: [String: String], header: [String: String]=[:], httpMethod: String) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.params = params
        self.header = header
        self.httpMethod = httpMethod
    }
}
