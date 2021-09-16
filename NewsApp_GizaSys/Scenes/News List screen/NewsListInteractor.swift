//
//  NewsListInteractor.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation

protocol NewsListInteractorProtocol {
    var presenter: NewsListPresenterProtocol?{get set}
    func getNews(for topic: String)
}

class NewsListInteractor {
    var presenter: NewsListPresenterProtocol?
    
}

extension NewsListInteractor : NewsListInteractorProtocol{
    
    func getNews(for topic: String) {
        NewsRequestsFactory.retrieveDaysNews(modelType: News.self, topic: topic) { [weak self] (news) in
            guard let news = news as? News, let articles = news.articles  else{
                self?.presenter?.articlesFetchedWithAnError(error: "a")
                return
            }
            let articlesArr = Array(articles)
            self?.presenter?.articlesFetchedSuccessfully(articles: articlesArr)
        }
    }
}
