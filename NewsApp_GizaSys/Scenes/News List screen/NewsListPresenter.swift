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
}

class NewsListPresenter{

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
    
    
}
