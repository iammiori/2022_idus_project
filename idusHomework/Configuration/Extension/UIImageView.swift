//
//  UIImageView.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/13.
//

import UIKit

struct ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
}
extension UIImageView {
    func loadImagefromURL(stringURL: String) {
        let cacheKey = NSString(string: stringURL)
        if let cachedImg = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cachedImg
            return
        }
        if stringURL.count > 0 {
            let url = URL(string: stringURL)
            DispatchQueue.global().async  { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            ImageCacheManager.shared.setObject(image, forKey: cacheKey)
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
