//
//  NewsListRouter.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation
import UIKit

protocol NewsListRouterProtocol {
    func createHomeModule() -> UIViewController
}

protocol Route {
    var destination: UIViewController{get}
    var style: NavigationStyle{get}
}

enum NavigationStyle {
    case push
    case modal
}


class NewsListRouter: NewsListRouterProtocol {
    weak var vc : UIViewController?
    
    
    func createHomeModule() -> UIViewController{
        guard  let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "\(NewsListViewController.self)") as? NewsListViewController else{
            
            fatalError("Couldn't find VC with the identifies \(NewsListViewController.self)")
        }
        let router = NewsListRouter()
        let interactor = NewsListInteractor()
        let presenter = NewsListPresenter(view: view, interactor: interactor, router: router)
        router.vc = view
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
        
    }
}

enum NewsListNavigationRouter: Route {
    
    case Details(Article)
    
    var destination: UIViewController{
        switch self {
        case .Details(let article):
            guard let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "\(DetailsViewController.self)") as? DetailsViewController else{
                fatalError("Couldn't find VC with the identifier \(DetailsViewController.self)")
            }
            
            let detailsPresenter = DetailsPresenter(view: detailsVC, article: article)
            detailsVC.presenter = detailsPresenter
            
            return detailsVC
        }
    }
    
    var style: NavigationStyle{
        switch self {
        case .Details:
            return.push
        }
    }
    
}
