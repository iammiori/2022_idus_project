//
//  Date.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/16.
//

import Foundation

extension Date {
    func changeStringtoDate(strDate: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
        return dateFormatter.date(from: strDate)!
    }
    var simpleDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
