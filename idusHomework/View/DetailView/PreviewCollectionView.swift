//
//  PreviewCollectionView.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/15.
//

import UIKit
import Combine

class PreviewCollectionView: UICollectionView {
    
    var subscriptions = Set<AnyCancellable>()
    let flowLayout = UICollectionViewFlowLayout()
 
    var cellsize: CGSize {
        let width =  ScreenConstant.deviceWidth * 0.6
        let height = width * PreviewImg.ratio
        return CGSize(width: width, height: height)
    }
    var bigCellSize: CGSize {
        let width =  ScreenConstant.deviceWidth * 0.7
        let height = width * PreviewImg.ratio
        return CGSize(width: width, height: height)
    }
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        setAttribute()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setAttribute() {
        self.backgroundColor = nil
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = false
        self.decelerationRate = .fast
        flowLayout.scrollDirection = .horizontal
        self.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.registerID)
    }
    func bind(_ viewModel : DetailViewModel) {
        viewModel.$appInfo
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                DispatchQueue.main.async {
                    self.reloadData()
                }
            }.store(in: &subscriptions)
    }
}
