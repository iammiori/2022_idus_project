//
//  FirstSearchBarView.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/12.
//

import UIKit

class FirstSearchBarView: UIView {
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "APP_ID를 입력해주세요."
        lb.textColor = .systemGray2
        lb.font = .systemFont(ofSize: 14, weight: .semibold)
        return lb
    }()
    let searchImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "magnifyingglass")
        iv.image = iv.image?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .systemGray
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
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.systemGray2.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setLayout() {
        [titleLabel, searchImageView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),

            searchImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }
}
