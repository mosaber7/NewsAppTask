//
//  NewsListRouter.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation
import UIKit

protocol NewsListRouterProtocol {
    
}

class NewsListRouter: NewsListRouterProtocol {
    weak var vc : UIViewController?
    
    
    static func createHomeModule() -> UIViewController{
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
