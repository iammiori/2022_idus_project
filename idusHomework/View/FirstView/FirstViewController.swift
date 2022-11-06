//
//  FirstViewController.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/12.
//

import UIKit

class FirstViewController: BaseViewController {

    let idusLogoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let searchBar = FirstSearchBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBackButton()
        setAttribute()
        setLayout()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        searchBar.addGestureRecognizer(tapGesture)
    }
    
    private func setNaviBackButton() {
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButton
    }
    private func setAttribute() {
        self.title = "iOS 이미연 홈워크"
    }
    private func setLayout() {
        [idusLogoImageView,searchBar].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            idusLogoImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            idusLogoImageView.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            idusLogoImageView.heightAnchor.constraint(equalTo: searchBar.heightAnchor),
            
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            searchBar.leadingAnchor.constraint(equalTo: idusLogoImageView.trailingAnchor, constant: 8)
        ])
    }
}

extension FirstViewController {
   @objc func handleTap(sender: UITapGestureRecognizer) {
       let searchVM = SearchViewModel(network: NetworkService(configuration: .default), searchedModel: AppStoreResponse.EMPTY)
       let nextVC = SearchViewController(viewModel: searchVM)
       self.navigationController?.pushViewController(nextVC, animated: true)
   }
}
