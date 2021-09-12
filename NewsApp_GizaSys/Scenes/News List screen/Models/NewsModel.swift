//
//  NewsModel.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation
import CoreData


// MARK: - Welcome
class News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

enum ArticleCodingKeys: String, CodingKey {
    case source = "source"
    case author, title
    case articleDescription = "description"
    case url, urlToImage, publishedAt, content
}

enum SourceCodingKeys: String, CodingKey {
    case id, name
    
}
// MARK: - Article
@objc(Article)
class Article: NSManagedObject, Codable {

    @NSManaged var author: String?
    @NSManaged var title, articleDescription: String?
    @NSManaged var url: String?
    @NSManaged var urlToImage: String?
    @NSManaged var publishedAt: String?
    @NSManaged var content: String?
    @NSManaged var sourceName: String?
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
              
              let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "Article", in: managedObjectContext) else {
   
            print("errorrrroo")
            // return
            fatalError("Failed to decode Account")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: ArticleCodingKeys.self)
        
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        
        self.articleDescription = try container.decodeIfPresent(String.self, forKey: .articleDescription)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        let sourceData  = try container.nestedContainer(keyedBy:
                                                          SourceCodingKeys.self, forKey: .source)
        self.sourceName = try (sourceData.decodeIfPresent(String.self, forKey: .name))
        
        
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ArticleCodingKeys.self)
        try container.encodeIfPresent(author, forKey: .author)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(articleDescription, forKey: .articleDescription)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(urlToImage, forKey: .urlToImage)
        try container.encodeIfPresent(publishedAt, forKey: .publishedAt)
        try container.encodeIfPresent(content, forKey: .content)
        

        var dataResponse  =  container.nestedContainer(keyedBy:
                                                        SourceCodingKeys.self, forKey: .source)
        try dataResponse.encodeIfPresent(sourceName, forKey: .name)
        
    }
    
    
}




