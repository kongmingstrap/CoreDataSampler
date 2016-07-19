//
//  NSManagedObjectContext+Extension.swift
//  CoreDataSampler
//
//  Created by tanaka.takaaki on 2016/05/28.
//  Copyright © 2016年 tanaka.takaaki. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    func insertObject<A: NSManagedObject where A: ManagedObjectType>() -> A {
        guard let obj = NSEntityDescription.insertNewObjectForEntityForName(A.entityName, inManagedObjectContext: self) as? A else {
            fatalError("Entity \(A.entityName) dose not correspond to \(A.self)")
        }
        return obj
    }
}
