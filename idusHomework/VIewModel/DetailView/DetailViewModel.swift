//
//  DetailViewModel.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/14.
//

import Foundation
import Combine

final class DetailViewModel {
    
    @Published private(set) var appInfo: AppStoreResponse?
    
    init(appInfo: AppStoreResponse) {
        self.appInfo = appInfo
    }
    
    let date = Date()
    
    func sliceDateFormat(str: String) -> String {
        let startIdx = str.index(str.startIndex, offsetBy: 0)
        let endIdx = str.index(str.startIndex, offsetBy: 9 )
        let slicedStr = str[startIdx ... endIdx]
        return String(slicedStr)
    }
    func checkNumberOfLine(_ lineCount: Int) -> Bool {
        return lineCount < 4 ? true : false
    }
    func convertByteToMB(_ byte: Int64) -> String {
        let byteFormatter = ByteCountFormatter()
        byteFormatter.allowedUnits = [.useMB]
        byteFormatter.countStyle = .file
        let strMB = byteFormatter.string(fromByteCount: byte)
        return strMB
    }
    
    var appName: String {
        return appInfo?.results[0].trackName ?? ""
    }
    var corpName: String {
        return appInfo?.results[0].sellerName ?? ""
    }
    var appLogoURL: String {
        return appInfo?.results[0].artworkUrl60 ?? ""
    }
    var description: String {
        return appInfo?.results[0].description ?? ""
    }
    var previewURLArr: [String] {
        return appInfo?.results[0].screenshotUrls ?? []
    }
    var releaseNote: String {
        return appInfo?.results[0].releaseNotes ?? ""
    }
    var currentVersionReleaseDate: String {
        let originDate = appInfo?.results[0].currentVersionReleaseDate ?? ""
        let onlyDate = sliceDateFormat(str: originDate)
        return onlyDate
    }
    var afterReleaseCount: String {
        let nowDate = date
        let releasDate = date.changeStringtoDate(strDate: currentVersionReleaseDate)
        let interval = nowDate.timeIntervalSince(releasDate)
        let count = Int(interval/86400)
        return "\(count) 일전"
        
    }
    var version: String {
        return appInfo?.results[0].version ?? ""
    }
    var versionWithDate: String {
        return "버전: \(version)  /  \(afterReleaseCount)"
    }
    var numberOfpreviewArr: Int {
        return previewURLArr.count
    }
    var korGenre: String {
        let originGenre = appInfo?.results[0].primaryGenreName ?? ""
        return originGenre.localized()
    }
    var corpNameANdfileSizeAndGenre: String {
        let fileSize = Int64(appInfo?.results[0].fileSizeBytes ?? "0")
        return "\(corpName)\n크기: \(convertByteToMB(fileSize!))  /  장르: \(korGenre)"
    }
}
