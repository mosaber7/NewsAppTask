//
//  NewsListNavigationRouter.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation
import UIKit

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
