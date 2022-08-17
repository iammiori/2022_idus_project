//
//  SearchViewModel.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/14.
//

import Foundation
import Combine

enum SearchState {
    case able
    case unable
}

final class SearchViewModel {
    
    let networkService: NetworkService
    
    init(network: NetworkService = NetworkService(configuration: .default), searchedModel: AppStoreResponse?) {
        self.networkService = network
        self.searchedModel = CurrentValueSubject(searchedModel)
    }
    
    var subscriptions = Set<AnyCancellable>()
    let searchedModel: CurrentValueSubject<AppStoreResponse?, Never>
   
    var buttonHidden: Bool {
        if searchedModel.value?.resultCount ?? 0 > 0 {
            return false
        } else {
            return true
        }
    }
    
    var name: String {
        if searchedModel.value?.resultCount ?? 0 > 0 {
            return searchedModel.value?.results[0].trackName ?? ""
        } else if searchedModel.value?.resultCount ?? 0 == 0 {
            return "검색결과가 없습니다"
        } else {
            return ""
        }
    }
    var logoImgURL: String {
        if searchedModel.value?.resultCount ?? 0 > 0 {
            return searchedModel.value?.results[0].artworkUrl60 ?? ""
        } else {
            return ""
        }
    }
    
    func search(appID: String) {
        let resource = NetworkResource<AppStoreResponse>(scheme: "http",
                                                         host: "itunes.apple.com",
                                                         path: "/lookup",
                                                         params: ["id":appID],
                                                         header: [:],
                                                         httpMethod: "GET")
        networkService.fetchInfo(resource)
            .receive(on: RunLoop.main)
            .sink { completion in
                print("completion: \(completion)")
                switch completion {
                case .failure(let error):
                    self.searchedModel.send(nil)
                case .finished:
                    break
                }
            } receiveValue: { appInfo in
                self.searchedModel.send(appInfo)
            }.store(in: &subscriptions)
    }
}
