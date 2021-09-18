//
//  CoreDataManagerTests.swift
//  NewsApp_GizaSysTests
//
//  Created by Saber on 18/09/2021.
//

import XCTest
import CoreData

@testable import NewsApp_GizaSys
class CoreDataManagerTests: XCTestCase {
    
    var sut: CoreDataManager!
    override  func setUp() {
        super.setUp()
        sut = CoreDataManager()
        
    }
    
    func test_setup_completionCalled() {
        let setupExpectation = expectation(description: "set up completion called")
        
        sut.setup(storeType: NSInMemoryStoreType) {
            setupExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func test_setup_persistentStoreCreated() {
        let setupExpectation = expectation(description: "set up completion called")
        
        sut.setup(storeType: NSInMemoryStoreType) {
                    setupExpectation.fulfill()
                }
        
        waitForExpectations(timeout: 1.0) { (_) in
            XCTAssertTrue(self.sut.persistentContainer.persistentStoreCoordinator.persistentStores.count > 0)
        }
    }
    
    func test_setup_persistentContainerLoadedOnDisk() {
            let setupExpectation = expectation(description: "set up completion called")
            
            sut.setup {
                XCTAssertEqual(self.sut.persistentContainer.persistentStoreDescriptions.first?.type, NSSQLiteStoreType)
                setupExpectation.fulfill()
            }
            
            waitForExpectations(timeout: 1.0) { (_) in
                self.sut.persistentContainer.destroyPersistentStore()
            }
        }
    func test_setup_persistentContainerLoadedInMemory() {
            let setupExpectation = expectation(description: "set up completion called")

            sut.setup(storeType: NSInMemoryStoreType) {
                XCTAssertEqual(self.sut.persistentContainer.persistentStoreDescriptions.first?.type, NSInMemoryStoreType)
                setupExpectation.fulfill()
            }

            waitForExpectations(timeout: 1.0, handler: nil)
        }
    
    func test_backgroundContext_concurrencyType() {
        let setupExpectation = expectation(description: "background context")

        sut.setup(storeType: NSInMemoryStoreType) {
            XCTAssertEqual(self.sut.backgroundContext.concurrencyType, .privateQueueConcurrencyType)
            setupExpectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_mainContext_concurrencyType() {
        let setupExpectation = expectation(description: "main context")

        sut.setup(storeType: NSInMemoryStoreType) {
            XCTAssertEqual(self.sut.mainContext.concurrencyType, .mainQueueConcurrencyType)
            setupExpectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_fetchCachedNews_fetchsuccessufully(){
        let articles = sut.fetchCachedNews()
        XCTAssertNotNil(articles)
        
    }
    
    func test_clearStorageFromEntity_ArticlesAreDeleted(){
        sut.clearStorageFromEntity(entityName: "Article")
        let articles = sut.fetchCachedNews()
        XCTAssertNotNil(articles)
        XCTAssertEqual(articles!.count, 0)
    }
    
}
