//
//  ImageWithLabelView.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/14.
//

import UIKit

enum Align {
    case leading
    case center
}
class ImageWithLabelView: UIView {
    
    let textLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 15, weight: .regular)
        return lb
    }()
    let imageView: UIImageView = {
        let iv = UIImageView()
        //iv.image = UIImage(named: "nosearch")
        iv.backgroundColor = .systemGray
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    let align: Align
    
    init(frame: CGRect = CGRect(), align: Align) {
        self.align = align
        super.init(frame: frame)
        setAttribute()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttribute() {
        self.backgroundColor = nil
    }
    private func setLayout() {
        [textLabel, imageView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        switch align {
        case .leading:
            NSLayoutConstraint.activate([
                imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
                
                textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
                textLabel.topAnchor.constraint(equalTo: imageView.topAnchor)
            ])
        case .center:
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
            ])
        }
    }
}
