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
    


}
