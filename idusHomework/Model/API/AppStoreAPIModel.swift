//
//  AppStoreAPIModel.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/13.
//

import Foundation
//http://itunes.apple.com/lookup?id=

struct AppStoreAPIModel {
    static let scheme = "http"
    static let host = "itunes.apple.com"
    static let path = "/lookup"
    
    func searchAppInfo(appID: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = AppStoreAPIModel.scheme
        components.host = AppStoreAPIModel.host
        components.path = AppStoreAPIModel.path
        components.queryItems = [
            URLQueryItem(name: "id", value: appID)
        ]
        return components
    }
}
