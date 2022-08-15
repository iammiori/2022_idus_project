//
//  AppStoreResponse.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/12.
//

import Foundation

struct AppStoreResponse: Codable {
    let resultCount: Int
    let results: [AppStoreResult]
}
struct AppStoreResult: Codable {
    let trackName: String
    let artworkUrl60: String
    let sellerName: String
    let description: String
    let screenshotUrls: [String]
}

extension AppStoreResponse {
    static let EMPTY = AppStoreResponse(resultCount: -1, results: [])
    static let PASSED = AppStoreResponse(resultCount: 1, results: [AppStoreResult(trackName: "", artworkUrl60: "", sellerName: "", description: "", screenshotUrls: [])])
}
