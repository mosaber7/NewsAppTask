//
//  NewsRequestsFactory.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation
import Alamofire
import CoreData


class NewsRequestsFactory{
    
    let backgroundContext: NSManagedObjectContext
    
    // MARK: - Init
    
    init(backgroundContext: NSManagedObjectContext = CoreDataManager.shared.backgroundContext) {
        self.backgroundContext = backgroundContext
    }
    
    // Block to handle responses in case of success and have data
    typealias NetworkSuccessBlock = (_ T:Decodable?)->Void
    // Block to handle responses in case of failure
    typealias NetworkFailureBlock = (Error?)->Void
    
    func retrieveDaysNews<T>(modelType:T.Type,topic: String, successBlock:@escaping NetworkSuccessBlock) where T : Decodable {
        
        AF.request(NewsURLFactory.News(topic)).responseJSON { (responce) in
            do{
                if responce.response?.statusCode == 200{
                    do{
                        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                            fatalError("Failed to retrieve managed object context")
                        }
                        // Parse JSON data to save accounts if needed
                        let jsonDecoder = JSONDecoder()
                        
                        
                        jsonDecoder.userInfo[codingUserInfoKeyManagedObjectContext] = self.backgroundContext
                        
                        
                        let modelResponse =   try jsonDecoder.decode(T.self, from: responce.data!)
                        print("\(modelResponse)")
                        
                        self.backgroundContext.performAndWait {
                            
                            do{
                                CoreDataManager.shared.clearStorageFromEntity(entityName: "Article")
                                try self.backgroundContext.save()}
                            catch{
                                print("failed to save t0 the database")
                            }
                        }
                        
                        // Parse JSON data to save
                        
                        jsonDecoder.userInfo[codingUserInfoKeyManagedObjectContext] = self.backgroundContext
                        let newsData =   try jsonDecoder.decode(T.self, from: responce.data!)
                        DispatchQueue.main.async {
                            successBlock(newsData)
                        }
                        
                    } catch let error{
                        
                    }
                }else{
                    
                    
                }
                
            }
        }
        
    }
    
}


