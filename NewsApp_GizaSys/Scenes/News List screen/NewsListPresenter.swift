//
//  NewsListPresenter.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation

protocol NewsListPresenterProtocol {
    var view: NewsListViewProtocol?{get set}
    var numberOfRowsInSection: Int {get}
    func configureCell() -> (String, String)
    func selectCell(at index: IndexPath)
    
    func articlesFetchedSuccessfully(articles: News)
    func articlesFetchedWithAnError(error: Error)
    func viewDidLoad()
}

class NewsListPresenter{

    private var articles: News?
    weak var view: NewsListViewProtocol?
    private let interactor: NewsListInteractorProtocol?
    private let router: NewsListRouterProtocol?
    var numberOfRowsInSection: Int {
        return 10
    }
    
    init(view: NewsListViewProtocol, interactor: NewsListInteractorProtocol, router: NewsListRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension NewsListPresenter: NewsListPresenterProtocol{
    
    
    func configureCell()-> (String, String) {
        return ("Mohamed", "Saber")
    }
    func selectCell(at index: IndexPath) {
        let detailsRoute = NewsListNavigationRouter.Details
        self.view?.navigate(to: detailsRoute)
    }
    func articlesFetchedSuccessfully(articles: News) {
        self.articles = articles
    }
    
    func articlesFetchedWithAnError(error: Error) {
        self.view?.presentAnAlert(error: error)
    }
    func viewDidLoad() {
        self.interactor?.getNews(for: "Apple")
    }
    
    
    
    
}
