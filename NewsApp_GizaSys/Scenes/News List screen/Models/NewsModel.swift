//
//  NewsModel.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation
import CoreData


@objc(News)
class News: NSManagedObject, Codable {
    @NSManaged var articles: Set<Article>?
    
    
    enum CodingKeys: String, CodingKey {
        case articles
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
              let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,let entity = NSEntityDescription.entity(forEntityName: "News", in: managedObjectContext) else {
            print("errorrrroo")
            // return
            fatalError("Failed to decode Account")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.articles = try container.decodeIfPresent(Set<Article>.self, forKey: .articles)
        
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(articles, forKey: .articles)
    }
    
    func getNewsModel()-> NewsViewModel?{
        var newsModel = NewsViewModel()
        guard let articles = articles else {
            return nil
        }
        newsModel.articles = Array(articles)
        return newsModel
    }
    
}

@objc(Article)
class Article: NSManagedObject, Codable {
    
    @NSManaged var author: String?
    @NSManaged var title, articleDescription: String?
    @NSManaged var url: String?
    @NSManaged var urlToImage: String?
    @NSManaged var publishedAt: String?
    @NSManaged var content: String?
    @NSManaged var name: String?
    
    
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case articleDescription = "description"
        case url
        case urlToImage
        case publishedAt
        case content
        case source
        
    }
    
    
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
              let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,let entity = NSEntityDescription.entity(forEntityName: "Article", in: managedObjectContext) else {
            print("errorrrroo")
            // return
            fatalError("Failed to decode Account")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(author, forKey: .author)
                try container.encodeIfPresent(title, forKey: .title)
                try container.encodeIfPresent(articleDescription, forKey: .articleDescription)
                try container.encodeIfPresent(url, forKey: .url)
                try container.encodeIfPresent(urlToImage, forKey: .urlToImage)
                try container.encodeIfPresent(publishedAt, forKey: .publishedAt)
                try container.encodeIfPresent(content, forKey: .content)
        
                var sourceContiner =  container.nestedContainer(keyedBy: SourceCodingKeys.self, forKey: .source)
                try sourceContiner.encodeIfPresent(name, forKey: .name)
        
    }
    
    
    
}
enum SourceCodingKeys: String, CodingKey {
    case id
    case name

}

struct NewsViewModel{
    var articles: [Article]?
}
