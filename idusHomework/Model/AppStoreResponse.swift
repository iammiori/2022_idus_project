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
    let artworkUrl60: String
    let sellerName: String
    let description: String
    let screenshotUrls: [String]
}
