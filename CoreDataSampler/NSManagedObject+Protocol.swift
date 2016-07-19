//
//  NSManagedObject+Protocol.swift
//  CoreDataSampler
//
//  Created by tanaka.takaaki on 2016/05/28.
//  Copyright © 2016年 tanaka.takaaki. All rights reserved.
//

import CoreData
import Foundation

protocol ManagedObjectType {
    static var entityName: String { get }
    
    static var defaultSortDescriptions: [NSSortDescriptor] { get }
}

extension ManagedObjectType {
    static var sortedFerchRequest: NSFetchRequest {
        let request = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptions
        return request
    }
}

protocol KeyCodable {
    associatedtype Key: RawRepresentable
}
