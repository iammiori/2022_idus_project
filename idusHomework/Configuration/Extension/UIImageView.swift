//
//  UIImageView.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/13.
//

import UIKit

extension UIImageView {
    func loadImagefromURL(stringURL: String) {
        if stringURL.count > 0 {
            let url = URL(string: stringURL)
            DispatchQueue.global().async  { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        } else {
            self.image = nil
        }
    }
}
