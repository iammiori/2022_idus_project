//
//  DetailViewController.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/13.
//

import UIKit
import Combine

class DetailViewController: BaseViewController {

    var viewModel: DetailViewModel
    var subscriptions = Set<AnyCancellable>()
    
    var itemSpacing: CGFloat = 18.0
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = true
        sv.bounces = false
        return sv
    }()
    let appInfoView = ImageWithLabelView(align: .leading)
    let versionView = ExpandableTextView()
    let previewView = PreviewCollectionView()
    let descriptionView = ExpandableTextView()
    lazy var containStackView: UIStackView = {
        let sv = UIStackView()
        [appInfoView, versionView, previewView, descriptionView].forEach { sv.addArrangedSubview($0) }
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
        setAttribute()
        setLayout()
        setCollectionView()
        setExpandableButton(descriptionView.expandableButton)
        setExpandableButton(versionView.expandableButton)
        bind()
    }
    
    private func setAttribute() {
        descriptionView.titleLabel.text = "앱 설명"
        versionView.titleLabel.text = "새로운 기능"
        versionView.expandableButton.tag = 2
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
        } else if sender.tag == 2 {
            versionView.changeTextViewHeight(.basic)
            versionView.expandableButton.setTitle("접기", for: .normal)
            versionView.expandableButton.tag = 3
        } else if sender.tag == 3 {
            versionView.changeTextViewHeight(.expand)
            versionView.expandableButton.setTitle("펼치기", for: .normal)
            versionView.expandableButton.tag = 2
        }
    }
    private func bind() {
        viewModel.$appInfo
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                self.versionView.subTitleLabel.text = self.viewModel.versionWithDate
                self.versionView.textView.text = self.viewModel.releaseNote
                let numberOfLine: Int = self.versionView.textView.getNumberOfLine()
                self.versionView.expandableButton.isHidden = self.viewModel.checkNumberOfLine(numberOfLine)
                self.appInfoView.textLabel.text = self.viewModel.appName
                self.appInfoView.subTitleLabel.text = self.viewModel.corpName
                self.appInfoView.imageView.loadImagefromURL(stringURL: self.viewModel.appLogoURL)
                self.descriptionView.textView.text = self.viewModel.description
                let numberOfLine2: Int = descriptionView.textView.getNumberOfLine()
                self.descriptionView.expandableButton.isHidden = self.viewModel.checkNumberOfLine(numberOfLine2)
                self.previewView.bind(viewModel)
                
            }.store(in: &subscriptions)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfpreviewArr
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.registerID, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        let eachURL = viewModel.previewURLArr[indexPath.row]
        cell.setData(eachURL)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previewImgURLS = viewModel.previewURLArr
        let extandVC = ExpandScreenImageViewController(viewModel: PreviewImgUrls(previewUrls: previewImgURLS),selectedIdx: indexPath.row)
        extandVC.modalPresentationStyle = .fullScreen
        extandVC.modalTransitionStyle = .coverVertical
        self.present(extandVC, animated: true)
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: itemSpacing, bottom: 0, right: itemSpacing) 
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = previewView.cellsize.width + itemSpacing
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
}
