//
//  NewsModel.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation
import CoreData


// MARK: - Welcome
@objc(News)
class News: NSManagedObject, Codable {
    

    @NSManaged var author: String?
    @NSManaged var title, articleDescription: String?
    @NSManaged var url: String?
    @NSManaged var urlToImage: String?
    @NSManaged var publishedAt: String?
    @NSManaged var content: String?
    @NSManaged var name: String?
    
    required convenience init(from decoder: Decoder) throws {
       
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "News", in: managedObjectContext) else {
                print("errorrrroo")
                // return
                fatalError("Failed to decode Account")
        }
   
    
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let parentContainer = try decoder.container(keyedBy: NewsCodingKeys.self)
        let container = try parentContainer.nestedContainer(keyedBy: ArticleCodingKeys.self, forKey: .articles)
        
        self.author =  try (container.decodeIfPresent(String.self, forKey: .author))
        self.title = try (container.decodeIfPresent(String.self, forKey: .title))
        self.articleDescription = try(container.decodeIfPresent(String.self, forKey: .articleDescription))
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        
        let sourceContainer = try container.nestedContainer(keyedBy: SourceCodingKeys.self, forKey: .source)
        
        self.name = try (sourceContainer.decodeIfPresent(String.self, forKey: .name))
        
        
 
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var parentContainer = encoder.container(keyedBy: NewsCodingKeys.self)
        var container = try parentContainer.nestedContainer(keyedBy: ArticleCodingKeys.self, forKey: .articles)
        
        try container.encodeIfPresent(author, forKey: .author)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(articleDescription, forKey: .articleDescription)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(urlToImage, forKey: .urlToImage)
        try container.encodeIfPresent(publishedAt, forKey: .publishedAt)
        try container.encodeIfPresent(content, forKey: .content)
        
        var sourceContiner = try container.nestedContainer(keyedBy: SourceCodingKeys.self, forKey: .source)
        try sourceContiner.encodeIfPresent(name, forKey: .name)

    }
    
    
}

enum NewsCodingKeys: String, CodingKey{
    case status
    case totalResults
    case articles
}

enum ArticleCodingKeys: String, CodingKey {
    
    case author, title
    case articleDescription = "description"
    case url, urlToImage, publishedAt, content
    case source
}

enum SourceCodingKeys: String, CodingKey {
    case id
    case name
    
}
// MARK: - Article




