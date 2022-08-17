//
//  ExpandScreenImageViewController.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/16.
//

import UIKit

class ExpandScreenImageViewController: BaseViewController {
    
    var viewModel: ExpandScreenImgViewModel
    let imageCollectionView = PreviewCollectionView()
    var itemSpacing: CGFloat = 18.0
    var selectedIdx: Int = 0
    
    let dismissButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("❎", for: .normal)
        bt.titleLabel?.font = .systemFont(ofSize: 17)
        return bt
    }()
    
    init(viewModel: PreviewImgUrls, selectedIdx: Int) {
        self.viewModel = ExpandScreenImgViewModel(screenImgArr: viewModel)
        self.selectedIdx = selectedIdx
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
    }
    override func viewDidLayoutSubviews() {
        self.imageCollectionView.scrollToItem(at:IndexPath(item: selectedIdx, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    private func setAttribute() {
        dismissButton.addTarget(self, action: #selector(dismissVC(_:)), for: .touchUpInside)
    }
    private func setLayout() {
        [imageCollectionView, dismissButton].forEach {self.view.addSubview($0)}
        [imageCollectionView, dismissButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 12),
            dismissButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            
            imageCollectionView.topAnchor.constraint(equalTo: self.dismissButton.bottomAnchor, constant: 10),
            imageCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            imageCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    private func setCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
}

extension ExpandScreenImageViewController {
    @objc func dismissVC(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension ExpandScreenImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfpreviewArr
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.registerID, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        let eachURL = viewModel.screenImgArr.previewUrls[indexPath.row]
        cell.setData(eachURL)
        return cell
    }
}

extension ExpandScreenImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ScreenConstant.deviceWidth - 100
        let height = width * PreviewImg.ratio
        return CGSize(width: width, height: height)
    }
}
