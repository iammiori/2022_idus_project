//
//  SearchViewController.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/12.
//

import UIKit

class SearchViewController: BaseViewController, UIGestureRecognizerDelegate {

    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "APP_ID를 입력해주세요."
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBarButton()
        setAttribute()
        setLayout()
        
        let networkService = NetworkService(configuration: .default)

        // 퍼블리셔 구독
        let subscription = networkService
            .fetchInfo(appID: 872469884) //퍼블리셔
            .receive(on: RunLoop.main)
            //.print()
            //.retry(3)
            .sink { completion in
                print("completion: \(completion)")
            } receiveValue: { info in
                print("Info :\(info)")
            }
    }
    private func setNaviBarButton() {
        self.navigationItem.titleView = searchBar
        let backBtn = UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBtn
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    private func setAttribute() {
        if #available(iOS 13.0, *) {
            searchBar.searchBarStyle = .default
            searchBar.searchTextField.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        }
    }
    private func setLayout() {
        
    }
}

extension SearchViewController {
}
