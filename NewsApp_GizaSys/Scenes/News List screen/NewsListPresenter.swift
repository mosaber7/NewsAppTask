//
//  NewsListPresenter.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation

protocol NewsListPresenterProtocol {
    var view: NewsListViewProtocol?{get }
    var numberOfRowsInSection: Int {get}
    
    
    
    func configureCell(index: Int)-> (String, String, URL?)?
    func selectCell(at index: IndexPath)
    func searchNews(with topic: String)
    func articlesFetchedSuccessfully(articles: [Article]?)
    func articlesFetchedWithAnError(error: String)
    func fetchData()
}

class NewsListPresenter{

    private(set) var articles: [Article]?
    weak var view: NewsListViewProtocol?
    private let interactor: NewsListInteractorProtocol?
    private let router: NewsListRouterProtocol?
    
    var numberOfRowsInSection: Int {
        if articles != nil, articles!.count > 20 {
            return 20
        }
        return articles?.count ?? 0
    }
    
    init(view: NewsListViewProtocol, interactor: NewsListInteractorProtocol, router: NewsListRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension NewsListPresenter: NewsListPresenterProtocol{
    func fetchData() {
        guard let articlesFetched = CoreDataManager.shared.fetchCachedNews() else {
            print("Error fetching data")
            return
        }
        print(articlesFetched.count)
        self.articles = articlesFetched
        view?.reloadData()
        
    }
    
    func searchNews(with topic: String) {
        self.view?.showIndicator()
        self.interactor?.getNews(for: topic)
    }
      
    
    func configureCell(index: Int)-> (String, String, URL?)?{
        guard let articles = articles,
              index <= articles.count else {
           return nil
        }
        let description = articles[index].title ?? ""
        let sourceName = articles[index].name ?? ""
        guard let  urlString = articles[index].urlToImage, let url = URL(string: urlString) else {
            return (description, sourceName, nil)
        }
return (description, sourceName, url)
    }
    func selectCell(at index: IndexPath) {
        guard let articles = articles else {
            return
        }
       let selectedArticle = articles[index.row]
        let detailsRoute = NewsListNavigationRouter.Details(selectedArticle)
        self.view?.navigate(to: detailsRoute)
    }
    func articlesFetchedSuccessfully(articles: [Article]?) {
        guard let articles = articles else{
            return
        }
        print("data Fetched successfully")
        self.articles = articles
        self.view?.hideIndicator()
        self.view?.reloadData()
        
    }
    
    func articlesFetchedWithAnError(error: String) {
        self.view?.presentAnAlert(error: error)
        view?.hideIndicator()
        self.view?.reloadData()
    }
    
}
