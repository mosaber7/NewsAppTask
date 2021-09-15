//
//  NewsRequestsFactory.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation
import Alamofire


class NewsRequestsFactory{

    // Block to handle responses in case of success and have data
    typealias NetworkSuccessBlock = (_ T:Decodable?)->Void
    // Block to handle responses in case of failure
    typealias NetworkFailureBlock = (AFError?)->Void
    
    static func retrieveDaysNews<T>(modelType:T.Type, successBlock:@escaping NetworkSuccessBlock) where T : Decodable {
        
        AF.request(NewsURLFactory.News("apple")).responseJSON { (responce) in
            do{

                if responce.response?.statusCode == 200{
                    do{
                        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                            fatalError("Failed to retrieve managed object context")
                        }
                        // Parse JSON data to save accounts if needed
                        let jsonDecoder = JSONDecoder()
                        
                        let managedObjectContext = coreDataManager.shared.persistentContainer.viewContext
                        jsonDecoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                        
                        
                        let modelResponse =   try jsonDecoder.decode(T.self, from: responce.data!)
                        print(modelResponse)
 
                        try managedObjectContext.save()
                        // Parse JSON data to save
                 
                      jsonDecoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                      let newsData =   try jsonDecoder.decode(T.self, from: responce.data!)
                      DispatchQueue.main.async {
                        successBlock(newsData)
                      }
                        
                    } catch let error{
                        print("ggggggg \(error)")
          //      fatalError("here")
                        
                    }
                }else{
                    
                }
                
            }
        }
        
    }
}
