//
//  SearchViewController.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/12.
//

import UIKit
import Combine

class SearchViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "APP_ID를 입력해주세요."
        return sb
    }()
    let searchedImgLabelView = ImageWithLabelView(align: .center)
    var searchBtn = UIBarButtonItem()
    let pushButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("상세보기", for: .normal)
        bt.backgroundColor = .idusOrange
        return bt
    }()
    
    var viewModel: SearchViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel(network: NetworkService(configuration: .default), searchedModel: AppStoreResponse.EMPTY)
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
        changeSearchState(searchState: .unable)
        navigationItem.rightBarButtonItem = searchBtn
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    private func changeSearchState(searchState: SearchState) {
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
        searchBar.becomeFirstResponder()
        if #available(iOS 13.0, *) {
            searchBar.searchBarStyle = .default
            searchBar.searchTextField.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        }
        pushButton.addTarget(self, action: #selector(pushButtonTapped(_:)), for: .touchUpInside)
    }
    private func setLayout() {
        [pushButton,searchedImgLabelView].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            searchedImgLabelView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            searchedImgLabelView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            searchedImgLabelView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            
            pushButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            pushButton.topAnchor.constraint(equalTo: searchedImgLabelView.bottomAnchor, constant: 10),
            pushButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12)
        ])
    }
    private func bind() {
        viewModel.searchedModel
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                self.searchedImgLabelView.textLabel.text = self.viewModel.name
                self.searchedImgLabelView.imageView.loadImagefromURL(stringURL: self.viewModel.logoImgURL)
                self.pushButton.isHidden = self.viewModel.buttonHidden
                self.searchedImgLabelView.imageView.isHidden = self.viewModel.buttonHidden
            }.store(in: &subscriptions)
    }
}

extension SearchViewController {
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func searchButtonTapped(_ sender: UIBarButtonItem) {
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        viewModel.search(appID: keyword)
        searchBar.resignFirstResponder()
    }
    @objc func pushButtonTapped(_ sender: UIButton) {
        let nextVC = DetailViewController(viewModel: viewModel.searchedModel.value!)
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            changeSearchState(searchState: .unable)
        } else {
            changeSearchState(searchState: .able)
        }
    }
}
