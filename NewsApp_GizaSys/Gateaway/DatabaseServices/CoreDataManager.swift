//
//  coreDataManager.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import Foundation
import CoreData



public class CoreDataManager: NSObject{
    
    static let shared = CoreDataManager()
    private var storeType: String!
    private var setupWasCalled = false
    
    
    override init() {
        super.init()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NewsModel")
        let description = container.persistentStoreDescriptions.first
        description?.type = storeType ?? NSSQLiteStoreType
        
        if !setupWasCalled{
            
        
        container.loadPersistentStores {(_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        }
        return container
    }()
    // MARK: - SetUp
    
    func setup(storeType: String = NSSQLiteStoreType, completion: (() -> Void)?) {
        setupWasCalled = true
        self.storeType = storeType
        loadPersistentStore {
            completion?()
        }
    }
    
    // MARK: - Loading
    
    private func loadPersistentStore(completion: @escaping () -> Void) {
        //handle data migration on a different thread/queue here
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
            
            completion()
        }
    }
    
    //MARK: - Contexts
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = self.persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }()
    
    //MARK: - for faster testing
    lazy var mainContext: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        
        return context
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK:-  Clear DB
    func clearStorageFromEntity(entityName:String) {
        let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
            return $0 ? true : $1.type == NSInMemoryStoreType
        }
        
        let managedObjectContext = mainContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        // NSBatchDeleteRequest is not supported for in-memory stores
        if isInMemoryStore {
            do {
                let users = try managedObjectContext.fetch(fetchRequest)
                for user in users {
                    managedObjectContext.delete(user as! NSManagedObject)
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedObjectContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    //MARK:-  fetch News from DB

    func fetchCachedNews()-> [Article]?{
        let fetchRequest = NSFetchRequest<Article>(entityName:"Article")
        var articles = [Article]()
        
        mainContext.performAndWait {
            do {
                articles = try mainContext.fetch(fetchRequest)
                // duplicate remover
                
            } catch let error {
                print(error)
                
            }
        }
        return articles.unique{ $0.title}
    }
    
}



