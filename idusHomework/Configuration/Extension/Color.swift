//
//  Color.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/12.
//

import UIKit

extension UIColor {

    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: Custom 색상 정의
    class var idusOrange: UIColor { UIColor(hex: 0xff7b30) }
}
