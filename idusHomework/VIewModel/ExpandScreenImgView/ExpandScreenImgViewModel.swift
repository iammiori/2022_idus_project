//
//  ExpandScreenImgViewModel.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/16.
//

import Foundation
import Combine

final class ExpandScreenImgViewModel {
    let screenImgArr: PreviewImgUrls
    
    init(screenImgArr: PreviewImgUrls) {
        self.screenImgArr = screenImgArr
    }
    
    var numberOfpreviewArr: Int {
        return screenImgArr.previewUrls.count    }
}
