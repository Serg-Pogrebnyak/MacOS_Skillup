//
//  Office.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 05.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation
import CoreData

class Office: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var address: String
    @NSManaged public var company: Company
    @NSManaged public var rooms: NSSet
    @NSManaged public var idLocal: String

    init(officeName: String, address: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Office", in: CoreManager.shared.coreManagerContext)!
        super.init(entity: entity, insertInto: CoreManager.shared.coreManagerContext)
        self.name = officeName
        self.address = address
        self.idLocal = UUID().uuidString
    }

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    @nonobjc public func fetchRequest() -> NSFetchRequest<Office> {
        return NSFetchRequest<Office>(entityName: "Office")
    }
}
