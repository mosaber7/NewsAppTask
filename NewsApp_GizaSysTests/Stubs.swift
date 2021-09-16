//
//  Stubs.swift
//  NewsApp_GizaSysTests
//
//  Created by Saber on 16/09/2021.
//

import Foundation
@testable import NewsApp_GizaSys

enum MockData{
    static var topic: String {
        return "Apple"
    }
    static var index: IndexPath{
        return IndexPath(row: 1, section: 0)
    }
    static var numberOfRowsInSection: Int{
        return 20
    }
}

class MockNewsListView: NewsListViewProtocol{
    var presenter: NewsListPresenterProtocol?
    var reloadDataIsCalled = false
    var presentAnAlertIsCalled = false
    var showIndicatorIScalled = false
    var hideIndicatorIscalled = false
    var navvigateIsCalled = false
    
    func reloadData() {
        reloadDataIsCalled = true
    }
    
    func presentAnAlert(error: String) {
     presentAnAlertIsCalled = true
    }
    
    func showIndicator() {
        showIndicatorIScalled = true
    }
    
    func hideIndicator() {
        hideIndicatorIscalled = true
    }
    
    func navigate(to route: Route) {
        navvigateIsCalled = true
    }
    
}
class MockNewsListInteractor: NewsListInteractorProtocol{
    var presenter: NewsListPresenterProtocol?
    
    func getNews(for topic: String) {
        NewsRequestsFactory.retrieveDaysNews(modelType: News.self, topic: MockData.topic) { (news) in
            
        }
    }
    
    
}

class MockNewsListRouter: NewsListRouterProtocol{
    
}

class MockNewsListPresenter: NewsListPresenterProtocol{
    var view: NewsListViewProtocol?
    
    var numberOfRowsInSection: Int {
        return MockData.numberOfRowsInSection
    }
    
    func configureCell(cell: HomeCellViewProtocol, index: Int) {
        
    }
    
    func selectCell(at index: IndexPath) {
        
    }
    
    func searchNews(with topic: String) {
        
    }
    
    func articlesFetchedSuccessfully(articles: [Article]?) {
        
    }
    
    func articlesFetchedWithAnError(error: String) {
        
    }
    
    func viewDidLoad() {
        
    }
    
    
}


