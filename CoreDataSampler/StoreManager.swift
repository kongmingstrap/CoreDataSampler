//
//  StoreManager.swift
//  CoreDataSampler
//
//  Created by tanaka.takaaki on 2016/05/28.
//  Copyright © 2016年 tanaka.takaaki. All rights reserved.
//

import CoreData

class StoreManager {
    
    private let ModelName = "CoreDataSampler"
    private let ModelExtension = "momd"
    private let StoreName = "CoreDataSampler.sqlite"
    
    private lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        guard let url = urls.first else {
            fatalError("Not found application documents directory")
        }
        
        return url
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent(self.StoreName)
        
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            fatalError("Failed to initialize the application's saved data")
        }
        
        return coordinator
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let url = NSBundle.mainBundle().URLForResource(self.ModelName, withExtension: self.ModelExtension)
        
        guard let contentsOfURL = url else {
            fatalError("Not found " + self.ModelName + "." + self.ModelExtension)
        }
        
        let managedObjectModel = NSManagedObjectModel(contentsOfURL: contentsOfURL)
        return managedObjectModel!
    }()
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    private(set) lazy var privateQueueContext: NSManagedObjectContext = {
        let privateQueueContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        privateQueueContext.parentContext = self.managedObjectContext
        return privateQueueContext
    }()
    
    static let sharedInstance = StoreManager()
    
    private init() {
        // do nothing
    }
}
