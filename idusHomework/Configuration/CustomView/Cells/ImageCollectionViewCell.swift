//
//  ImageCollectionViewCell.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/15.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let registerID = "\(UICollectionViewCell.self)"
    
    let imgView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttribute()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setAttribute() {
        layer.cornerRadius = 18.0
        layer.masksToBounds = true
    }
    private func setLayout() {
        self.addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.setEdgesAnchor(superView: self)
    }
    func setData(_ stringURL: String) {
        self.imgView.loadImagefromURL(stringURL: stringURL)
    }
}
