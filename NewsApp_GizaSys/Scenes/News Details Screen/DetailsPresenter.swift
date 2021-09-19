//
//  DetailsPresenter.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation
import SafariServices



protocol DetailsPresenterProtocol {
    var view: DetailsViewProtocol?{get}
    var title: String {get}
    var description: String{get}
    var content: String{get}
    var imageUrl: URL?{get}
    func webNavigate()
    
}

class DetailsPresenter{
    private var article: Article?
    weak var view: DetailsViewProtocol?
    
    init(view: DetailsViewProtocol, article: Article) {
        self.view = view
        self.article = article
    }
    
}

extension DetailsPresenter: DetailsPresenterProtocol{
    var title: String{
        return article?.title ?? "??"
    }
    var description: String{
        return article?.articleDescription ?? "??"
    }
    var content: String{
        return article?.content ?? ""
    }
    var imageUrl: URL?{
        guard let urlString = article?.urlToImage, let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    func webNavigate() {
        guard let urlString = article?.url, let url = URL(string: urlString) else {
            return
        }
        let svc = SFSafariViewController(url: url)
        self.view?.present(view: svc)
    }
    
}
