//
//  NewsListPresenterTests.swift
//  NewsApp_GizaSysTests
//
//  Created by Saber on 16/09/2021.
//

import XCTest
@testable import NewsApp_GizaSys

class NewsListPresenterTests: XCTestCase {
    var sut: NewsListPresenter?
    var view = MockNewsListView()
    var interactor = MockNewsListInteractor()
    var router = MockNewsListRouter()
    
    override func setUp() {
        super.setUp()
        sut = NewsListPresenter(view: view, interactor: interactor, router: router)
        interactor.presenter = sut
        view.presenter = sut
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    func test_searchNews_indicatorIsShown(){
        sut?.searchNews(with: MockData.topic)
        XCTAssertTrue(view.showIndicatorIScalled)
    }
    func test_selectCell_Navigated(){
        sut?.viewDidLoad()
        sut?.selectCell(at: MockData.index)
        XCTAssertTrue(view.navvigateIsCalled)
    }
    
    func test_articlesFetchedSuccessfully_IndicatorIsHidden(){
        sut?.articlesFetchedSuccessfully(articles: [])
        XCTAssertTrue(view.hideIndicatorIscalled)
        XCTAssertTrue(view.reloadDataIsCalled)

    }
    func test_articlesFetchedWithAnError_AlertPresented(){
        sut?.articlesFetchedWithAnError(error: "")
        XCTAssertTrue(view.presentAnAlertIsCalled)
        XCTAssertTrue(view.hideIndicatorIscalled)
        XCTAssertTrue(view.reloadDataIsCalled)
    }
    


}
