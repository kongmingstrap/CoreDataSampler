//
//  Event.swift
//  CoreDataSampler
//
//  Created by tanaka.takaaki on 2016/05/28.
//  Copyright © 2016年 tanaka.takaaki. All rights reserved.
//

import CoreData

final class Event: NSManagedObject {
    
    @NSManaged var title: String
    
    @NSManaged var subTitle: String
    
    @NSManaged var timeStamp: NSDate
}

extension Event: ManagedObjectType {
    @nonobjc static let entityName = "Event"
    
    @nonobjc static var defaultSortDescriptions: [NSSortDescriptor] {
        return [NSSortDescriptor(key: Event.Key.timeStamp.rawValue, ascending: false)]
    }
}

extension Event: KeyCodable {
    enum Key: String {
        case title
        case subTitle
        case timeStamp
    }
}
