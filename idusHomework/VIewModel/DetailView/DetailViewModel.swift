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
}
