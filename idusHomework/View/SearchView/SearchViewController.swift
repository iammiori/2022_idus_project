//
//  SearchViewController.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/12.
//

import UIKit
import Combine

enum SearchState {
    case able
    case unable
}
class SearchViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "APP_ID를 입력해주세요."
        return sb
    }()
    let logoImageview: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .darkGray
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Hello"
        lb.textColor = .systemGray2
        lb.font = .systemFont(ofSize: 14, weight: .semibold)
        lb.sizeToFit()
        return lb
    }()
    var searchBtn = UIBarButtonItem()
    let pushButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("상세보기", for: .normal)
        bt.backgroundColor = .yellow
        return bt
    }()
    
    let api = AppStoreAPIModel()
    let networkService = NetworkService(configuration: .default)
    
    @Published private(set) var appInfo: AppStoreResponse?
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBarButton()
        setAttribute()
        setLayout()
        bind()
    }
    
    private func setNaviBarButton() {
        self.navigationItem.titleView = searchBar
        let backBtn = UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(backButtonTapped(_:)))
        searchBtn = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                        style: .done,
                                        target: self,
                                        action: #selector(searchButtonTapped(_:)))
        navigationItem.leftBarButtonItem = backBtn
        checkSearchState(searchState: .unable)
        navigationItem.rightBarButtonItem = searchBtn
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    private func checkSearchState(searchState: SearchState) {
        switch searchState {
        case .unable:
            searchBtn.tintColor = .darkGray
            searchBtn.isEnabled = false
        case .able:
            searchBtn.tintColor = .systemBlue
            searchBtn.isEnabled = true
        }
    }
    private func setAttribute() {
        searchBar.delegate = self
        searchBar.keyboardType = .asciiCapableNumberPad
        if #available(iOS 13.0, *) {
            searchBar.searchBarStyle = .default
            searchBar.searchTextField.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        }
        pushButton.addTarget(self, action: #selector(pushButtonTapped(_:)), for: .touchUpInside)
    }
    private func setLayout() {
        [nameLabel,pushButton,logoImageview].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            pushButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            pushButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            pushButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            
            logoImageview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoImageview.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -20),
            logoImageview.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2),
            logoImageview.heightAnchor.constraint(equalTo: logoImageview.widthAnchor)
        ])
    }
    private func bind() {
        $appInfo
            .receive(on: RunLoop.main)
            .sink { [unowned self] result in
                self.update(result)
            }.store(in: &subscriptions)
    }
    private func update(_ response: AppStoreResponse?) {
        guard let response = response else {
            self.nameLabel.text = "검색결과가 없어요"
            return
        }
        if response.resultCount != 0 {
            self.nameLabel.text = response.results[0].sellerName
            self.logoImageview.loadImagefromURL(url: URL(string: response.results[0].artworkUrl60)!)
        } else {
            self.nameLabel.text = "검색결과가 없어요"
        }
    }
}

extension SearchViewController {
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func searchButtonTapped(_ sender: UIBarButtonItem) {

        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        guard let url = api.searchAppInfo(appID: keyword).url else { return }
    
        let subscription = networkService
            .fetchInfo(url: url)
            .receive(on: RunLoop.main)
            .sink { completion in
                print("completion: \(completion)")
                //에러처리
                switch completion {
                case .failure(let error):
                    self.appInfo = nil
                case .finished:
                    break
                }
            } receiveValue: { appInfo in
                self.appInfo = appInfo
            }.store(in: &subscriptions)
    }
    @objc func pushButtonTapped(_ sender: UIButton) {
        let nextVC = DetailViewController()
        nextVC.appInfo = appInfo
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            checkSearchState(searchState: .unable)
        } else {
            checkSearchState(searchState: .able)
        }
    }
}
