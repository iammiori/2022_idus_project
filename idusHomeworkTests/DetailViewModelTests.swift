//
//  DetailViewModelTests.swift
//  idusHomeworkTests
//
//  Created by miori Lee on 2022/08/15.
//

import XCTest
@testable import idusHomework

class DetailViewModelTests: XCTestCase {
    
    var sut: DetailViewModel!
    var model: AppStoreResponse!

    override func setUpWithError() throws {
        try super.setUpWithError()
        model = AppStoreResponse.PASSED
        sut = DetailViewModel(appInfo: model)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        model = nil
    }

    func test_model의_데이터가_의도된대로_viewModel프로퍼티에_담기는지() {
        //given
        let model = AppStoreResponse(resultCount: 1, results: [AppStoreResult(trackName: "testTrackName", artworkUrl60: "testArtworkUrl60", sellerName: "testSellerName", description: "testDescription", screenshotUrls: ["test1","test2"])])

        let viewModel = DetailViewModel(appInfo: model)
        //when
        //then
        XCTAssertEqual(viewModel.appName, "testTrackName")
        XCTAssertEqual(viewModel.corpName, "testSellerName")
        XCTAssertEqual(viewModel.appLogoURL, "testArtworkUrl60")
        XCTAssertEqual(viewModel.description, "testDescription")
        XCTAssertEqual(viewModel.previewURLArr, ["test1","test2"])
    }
    
    func test_previewURLArr의_길이를_제대로_반환하는지() {
        //given
        let model = AppStoreResponse(resultCount: 1, results: [AppStoreResult(trackName: "testTrackName", artworkUrl60: "testArtworkUrl60", sellerName: "testSellerName", description: "testDescription", screenshotUrls: ["test1","test2"])])

        let viewModel = DetailViewModel(appInfo: model)
        //when
        //then
        XCTAssertEqual(viewModel.numberOfpreviewArr, 2)
    }

}
