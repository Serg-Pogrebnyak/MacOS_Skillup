//
//  Room.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 05.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation
import CoreData

class Room: NSManagedObject {
    @NSManaged public var roomNumber: String
    @NSManaged public var team: NSSet
    @NSManaged public var office: Office
    @NSManaged public var idLocal: String

    init(roomNumber: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Room", in: CoreManager.shared.coreManagerContext)!
        super.init(entity: entity, insertInto: CoreManager.shared.coreManagerContext)
        self.roomNumber = roomNumber
        self.idLocal = UUID().uuidString
    }

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    @nonobjc public func fetchRequest() -> NSFetchRequest<Room> {
        return NSFetchRequest<Room>(entityName: "Room")
    }
}
