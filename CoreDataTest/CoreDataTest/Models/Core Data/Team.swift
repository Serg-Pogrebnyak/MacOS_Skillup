//
//  Team.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 05.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation
import CoreData

class Team: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var rooms: NSSet
    @NSManaged public var groups: NSSet
    @NSManaged public var company: Company
    @NSManaged public var idLocal: String

    init(teamName: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Team", in: CoreManager.shared.coreManagerContext)!
        super.init(entity: entity, insertInto: CoreManager.shared.coreManagerContext)
        self.name = teamName
        self.idLocal = UUID().uuidString
    }

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    @nonobjc public func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }
}
