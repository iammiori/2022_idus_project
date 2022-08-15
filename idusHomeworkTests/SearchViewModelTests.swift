//
//  SearchViewModelTests.swift
//  idusHomeworkTests
//
//  Created by miori Lee on 2022/08/14.
//

import XCTest
@testable import idusHomework

class SearchViewModelTests: XCTestCase {
    
    var sut: SearchViewModel!
    var model: AppStoreResponse!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SearchViewModel(searchedModel: model)
        model = AppStoreResponse.EMPTY
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        model = nil
    }
    
    func test_viewDidLoad될때_버튼_hidden이_true인지() {
        //given
        let model = AppStoreResponse(resultCount: -1, results: [])
        let viewModel = SearchViewModel(searchedModel: model)
        //when
        //then
        XCTAssertEqual(viewModel.buttonHidden, true)
    }
    
    func test_검색결과가있을때_버튼_hidden이_false인지() {
        //given
        let model = AppStoreResponse(resultCount: 1, results: [AppStoreResult(trackName: "testTrackName", artworkUrl60: "testArtworkUrl60",
                                                                              sellerName: "testSellerName",
                                                                              description: "testDescription",
                                                                              screenshotUrls: ["test1","test2","test3"])])
        let viewModel = SearchViewModel(searchedModel: model)
        //when
        //then
        XCTAssertEqual(viewModel.buttonHidden, false)
    }
    
    func test_검색결과가없을때_버튼_hidden이_true인지() {
        //given
        let model = AppStoreResponse(resultCount: 0, results: [])
        let viewModel = SearchViewModel(searchedModel: model)
        //when
        //then
        XCTAssertEqual(viewModel.buttonHidden, true)
    }
    
    func test_검색결과가있을때_model의_데이터가_의도된대로_viewModel프로퍼티에_담기는지() {
        //given
        let model = AppStoreResponse(resultCount: 1, results: [AppStoreResult(trackName: "testTrackName", artworkUrl60: "testArtworkUrl60",
                                                                              sellerName: "testSellerName",
                                                                              description: "testDescription",
                                                                              screenshotUrls: ["test1","test2","test3"])])
        let viewModel = SearchViewModel(searchedModel: model)
        //when
        //then
        XCTAssertEqual(viewModel.name, "testSellerName")
        XCTAssertEqual(viewModel.logoImgURL, "testArtworkUrl60")
    }
    
    func test_검색결과가없을때_model의_데이터가_의도된대로_viewModel프로퍼티에_담기는지() {
        //given
        let model = AppStoreResponse(resultCount: 0, results: [])
        let viewModel = SearchViewModel(searchedModel: model)
        //when
        //then
        XCTAssertEqual(viewModel.name, "검색결과가 없습니다")
        XCTAssertEqual(viewModel.logoImgURL, "")
    }
}
