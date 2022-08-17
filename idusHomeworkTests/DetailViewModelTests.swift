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

    func test_model의_데이터가_정상적일때_의도된대로_viewModel프로퍼티에_담기는지() {
        //given
        let model = AppStoreResponse(resultCount: 1, results: [AppStoreResult(trackName: "testTrackName", artworkUrl60: "testArtworkUrl60", sellerName: "testSellerName", description: "testDescription", screenshotUrls: ["test1","test2","test3"], releaseNotes: "testRelease", version: "testVersion", currentVersionReleaseDate: "2022-08-16T02:05:27Z", fileSizeBytes: "12345", primaryGenreName: "Social Networking")])

        let viewModel = DetailViewModel(appInfo: model)
        //when
        //then
        XCTAssertEqual(viewModel.appName, "testTrackName")
        XCTAssertEqual(viewModel.corpName, "testSellerName")
        XCTAssertEqual(viewModel.appLogoURL, "testArtworkUrl60")
        XCTAssertEqual(viewModel.description, "testDescription")
        XCTAssertEqual(viewModel.previewURLArr, ["test1","test2","test3"])
        XCTAssertEqual(viewModel.releaseNote, "testRelease")
        XCTAssertEqual(viewModel.currentVersionReleaseDate, "2022-08-16")
        XCTAssertEqual(viewModel.version,"testVersion")
        XCTAssertEqual(viewModel.numberOfpreviewArr, 3)
        XCTAssertEqual(viewModel.korGenre, "소셜 네트워킹")
    }
    
    func test_sliceDateFormat_호출시_yyyyMMdd_포맷을_반환하는지() {
        let str = "2022-08-16T02:05:27Z"
        let result = sut.sliceDateFormat(str: str)
        XCTAssertEqual(result, "2022-08-16")
    }
    
    func test_checkNumberOfLine_호출시_lineCount가_4미만일때_true를_반환하는지() {
        let lineCount: Int = 3
        let reuslt = sut.checkNumberOfLine(lineCount)
        XCTAssertEqual(reuslt, true)
    }
    
    func test_checkNumberOfLine_호출시_lineCount가_4이상일때_false를_반환하는지() {
        let lineCount: Int = 20
        let reuslt = sut.checkNumberOfLine(lineCount)
        XCTAssertEqual(reuslt, false)
    }
    
    func test_convertByteToMB_호출시_제대로_계산하는지() {
        let byteNum: Int64 = 1048576
        let mbNum = sut.convertByteToMB(byteNum)
        XCTAssertEqual(mbNum, "1MB")
    }

}
