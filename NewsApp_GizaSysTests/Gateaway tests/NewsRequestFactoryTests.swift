//
//  NewsRequestFactoryTests.swift
//  NewsApp_GizaSysTests
//
//  Created by Saber on 18/09/2021.
//

import XCTest
import CoreData

@testable import NewsApp_GizaSys

class NewsRequestFactoryTests: XCTestCase {
    
    var sut: NewsRequestsFactory!
    var coreDataStack: CoreDataTestStack!
    
    override func setUp() {
        coreDataStack = CoreDataTestStack()
        sut = NewsRequestsFactory(backgroundContext: coreDataStack.backgroundContext)
    }
    
    //checks that the context that we pass into NewsRequestsFactory is the same context that is assigned to the backgroundContext property.
    
    func test_init_contexts() {
        XCTAssertEqual(sut.backgroundContext, coreDataStack.backgroundContext)
    }
    func test_retrieveDaysNews_newsRetrivedAndSaved(){
      
        self.sut.retrieveDaysNews(modelType: News.self, topic: MockData.topic) { (news) in
            XCTAssertNotNil(news)
        }
        
    }
    
    
    
}
