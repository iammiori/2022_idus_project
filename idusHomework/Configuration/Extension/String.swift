//
//  String.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/17.
//

import Foundation

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
