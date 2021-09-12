//
//  Route.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation
import UIKit

protocol Route {
    var destination: UIViewController{get}
    var style: NavigationStyle{get}
}

enum NavigationStyle {
    case push
    case modal
}
