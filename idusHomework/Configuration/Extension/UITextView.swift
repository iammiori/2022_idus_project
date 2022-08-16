//
//  UITextView.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/17.
//

import UIKit

extension UITextView {
    func getNumberOfLine() -> Int {
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)
        return Int(estimatedSize.height / (self.font!.lineHeight))
    }
}
// reference : https://woongsios.tistory.com/95
