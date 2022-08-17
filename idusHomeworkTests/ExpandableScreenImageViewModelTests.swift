//
//  ExpandableScreenImageViewModelTests.swift
//  idusHomeworkTests
//
//  Created by miori Lee on 2022/08/17.
//

import XCTest
@testable import idusHomework

class ExpandableScreenImageViewModelTests: XCTestCase {
    
    var sut: ExpandScreenImgViewModel!
    var model : PreviewImgUrls!

    override func setUpWithError() throws {
        sut = ExpandScreenImgViewModel(screenImgArr: model)
        model = PreviewImgUrls.EMPTY
    }

    override func tearDownWithError() throws {
        sut = nil
        model = nil
    }
    
    func 받아온_이미지_배열의_크기를_제대로_반환하는지() {
        let model = PreviewImgUrls(previewUrls: ["url1","url2"])
        let viewModel = ExpandScreenImgViewModel(screenImgArr: model)
        XCTAssertEqual(viewModel.numberOfpreviewArr, 2)
    }
}
