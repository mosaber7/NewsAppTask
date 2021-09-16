//
//  NewsListInteractorTests.swift
//  NewsApp_GizaSysTests
//
//  Created by Saber on 16/09/2021.
//

import XCTest
@testable import NewsApp_GizaSys

class NewsListInteractorTests: XCTestCase {

    var sut: NewsListInteractor?
    var presenter = MockNewsListPresenter()
    var view = MockNewsListView()
    
    override  func setUp() {
        sut = NewsListInteractor()
        presenter.view = view
        sut?.presenter = presenter
    }
    
    

}
