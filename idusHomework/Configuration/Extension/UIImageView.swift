//
//  UIImageView.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/13.
//

import UIKit

extension UIImageView {
    func loadImagefromURL(url: URL) {
        DispatchQueue.global().async  { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
