//
//  BaseViewController.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/12.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        setNaviAttribute()
    }
    
    private func setAttribute() {
        self.view.backgroundColor = .white
        // issue solution : pop 했을때 검정선 보이는 이슈 해결
        self.extendedLayoutIncludesOpaqueBars = true
    }
    private func setNaviAttribute() {
        //MARK: 네비바 아래 실선 1Px 짜리 없애기
        let appearance = UINavigationBarAppearance()
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        appearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        // 네비바 색 입히고 글자색 바꾸기
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .darkGray
        
        if #available(iOS 15, *) {
            self.navigationController?.navigationBar.compactAppearance = appearance
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
}
