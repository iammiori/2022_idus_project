//
//  DetailViewController.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/13.
//

import UIKit
import Combine

class DetailViewController: BaseViewController {

    var viewModel: DetailViewModel?
    var itemSpacing: CGFloat = 18.0
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = true
        sv.bounces = false
        return sv
    }()
    let appInfoView = ImageWithLabelView(align: .leading)
    let previewView = PreviewCollectionView()
    let descriptionView = ExpandableTextView()
    lazy var containStackView: UIStackView = {
        let sv = UIStackView()
        [appInfoView, previewView, descriptionView].forEach { sv.addArrangedSubview($0) }
        sv.axis = .vertical
        sv.spacing = 12
        sv.alignment = .fill
        sv.distribution = .fill
        sv.backgroundColor = nil
        return sv
    }()
    
    init(viewModel: AppStoreResponse) {
        self.viewModel = DetailViewModel(appInfo: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("dd:\(viewModel?.appInfo?.results[0].sellerName)")
        setAttribute()
        setLayout()
        setCollectionView()
        setExpandableButton(descriptionView.expandableButton)
    }
    
    private func setAttribute() {
        
    }
    private func setLayout() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(containStackView)
        
        [scrollView, containStackView, previewView, descriptionView.textView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        containStackView.setEdgesAnchor(superView: self.scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            containStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            previewView.heightAnchor.constraint(equalToConstant: previewView.cellsize.height)
        ])
    }
    private func setCollectionView() {
        previewView.delegate = self
        previewView.dataSource = self
    }
    private func setExpandableButton(_ btn: UIButton) {
        btn.addTarget(self, action: #selector(expandableBtnTapped(_:)), for: .touchUpInside)
    }
    @objc func expandableBtnTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            descriptionView.changeTextViewHeight(.basic)
            self.view.layoutIfNeeded()
            descriptionView.expandableButton.setTitle("접기", for: .normal)
            descriptionView.expandableButton.tag = 1
        } else if sender.tag == 1 {
            descriptionView.changeTextViewHeight(.expand)
            self.view.layoutIfNeeded()
            descriptionView.expandableButton.setTitle("펼치기", for: .normal)
            descriptionView.expandableButton.tag = 0
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.registerID, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: itemSpacing, bottom: 0, right: itemSpacing)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = previewView.cellsize.width + itemSpacing
        let height = previewView.cellsize.height
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == previewView {
            let cellWidth = previewView.cellsize.width + (itemSpacing*2)
            var offset = targetContentOffset.pointee
            let index = (offset.x + scrollView.contentInset.left) / cellWidth
            let roundedIndex: CGFloat = round(index)
            offset = CGPoint(x: (roundedIndex * cellWidth - scrollView.contentInset.left) - itemSpacing, y: scrollView.contentInset.top)
            targetContentOffset.pointee = offset
        }
    }
}
