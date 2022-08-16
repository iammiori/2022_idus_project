//
//  DetailViewModel.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/14.
//

import Foundation
import Combine

final class DetailViewModel {
    @Published private(set) var appInfo: AppStoreResponse?
    
    init(appInfo: AppStoreResponse) {
        self.appInfo = appInfo
    }
    
    var appName: String {
        return appInfo?.results[0].trackName ?? ""
    }
    var corpName: String {
        return appInfo?.results[0].sellerName ?? ""
    }
    var appLogoURL: String {
        return appInfo?.results[0].artworkUrl60 ?? ""
    }
    var description: String {
        return appInfo?.results[0].description ?? ""
    }
    var previewURLArr: [String] {
        return appInfo?.results[0].screenshotUrls ?? []
    }
    var numberOfpreviewArr: Int {
        return previewURLArr.count
    }
}
