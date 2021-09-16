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
    func configureCell(at index: Int) -> (String, String, URL?)
    func selectCell(at index: IndexPath)
    func searchNews(with topic: String)
    func articlesFetchedSuccessfully(articles: Set<Article>?)
    func articlesFetchedWithAnError(error: String)
    func viewDidLoad()
}

class NewsListPresenter{

    private var articles: [Article]?
    private var intialArticles: [Article]?
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
    func viewDidLoad() {
//        guard let articles = coreDataManager.shared.fetchCachedNews()?.articles as? [Article]?, let articlesArr = articles else {
//        
//            return
//        }
//        for article in articlesArr{
//            self.articles?.append(article)
//        }
//        print(articles?.count)
//        view?.reloadData()
    }
    func searchNews(with topic: String) {
        self.view?.showIndicator()
        self.interactor?.getNews(for: topic)
    }
      
    
    func configureCell(at index: Int)-> (String,String, URL?) {
        guard let articles = articles,
            index <= articles.count else {
            return ("","", nil)
        }
        guard let  urlString = articles[index].urlToImage, let url = URL(string: urlString) else {
            return (articles[index].title!, articles[index].name!, nil)
            
        }
        
        return (articles[index].title!, articles[index].name!, url)
    }
    func selectCell(at index: IndexPath) {
        guard let articles = articles else {
            return
        }
       let selectedArticle = articles[index.row]
        let detailsRoute = NewsListNavigationRouter.Details(selectedArticle)
        self.view?.navigate(to: detailsRoute)
    }
    func articlesFetchedSuccessfully(articles: Set<Article>?) {
        guard let articles = articles else{
            return
        }
        print("data Fetched successfully")
        self.articles = Array(articles)
        self.view?.hideIndicator()
        self.view?.reloadData()
        
    }
    
    func articlesFetchedWithAnError(error: String) {
        self.view?.presentAnAlert(error: error)
        self.articles = coreDataManager.shared.fetchCachedNews()?.articles as? [Article]

        self.view?.reloadData()
    }
    
}
