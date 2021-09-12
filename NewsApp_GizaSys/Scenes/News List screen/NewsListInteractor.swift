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
    
    }
}
