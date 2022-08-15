//
//  UIView.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/15.
//

import UIKit

extension UIView {
    func setEdgesAnchor(superView: UIView, inset: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: inset.top),
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: inset.left),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -inset.right),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -inset.bottom)
        ])
    }
}
