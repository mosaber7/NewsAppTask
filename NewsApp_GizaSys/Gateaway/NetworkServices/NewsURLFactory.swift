//
//  NewsRouter.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation
import Alamofire

//http://newsapi.org/v2/everything?q=apple&from=2021-09-11&to=2021-09-11&sortBy=popularity&apiKey=API_KEY

enum NewsURLFactory: URLRequestConvertible{
    
    static let baseUrl = "http://newsapi.org/v2/everything?q="
    
    case News(String)
    
    var topic: String {
        switch self {
        case .News(let topic):
            return "\(topic)"
        }
    }
    
    var httpMethod: HTTPMethod?{
        return .get
    }
    
    var APIKey: String {
        switch self {
        case .News:
            return "&apiKey=fc21d5f568dd47d0b323976938021c25"
        }
    }
    
    var parameters:  [String: Any]?{
        return nil
    }
    
    var headers: [String: String]{
        return [:]
    }
    
    var encoding: ParameterEncoding{
        return JSONEncoding.default
    }
    var sortMethod: String{
        return "&sortBy=popularity"
    }
    var startDate: String{
        return "&from=2021-09-11"
    }
    var endDate: String{
        return "&to=2021-09-11"
    }
    func asURLRequest() throws -> URLRequest {
        let urlString = NewsURLFactory.baseUrl + self.topic + self.startDate + self.endDate + self.sortMethod + self.APIKey
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.method = self.httpMethod
        request.headers = HTTPHeaders(headers)
        return try! encoding.encode(request, with: self.parameters)
    }
    
    
}

