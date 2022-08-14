//
//  DetailViewController.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/13.
//

import UIKit
import Combine

class DetailViewController: UIViewController {

    var viewModel: DetailViewModel?
    
    init(viewModel: AppStoreResponse) {
        self.viewModel = DetailViewModel(appInfo: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("dd:\(viewModel?.appInfo?.resultCount)")
    }

}
