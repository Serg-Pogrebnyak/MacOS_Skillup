//
//  Company.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 05.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation
import CoreData

class Company: NSManagedObject, TableViewFirstColumnProtocol {
    @NSManaged public var name: String
    @NSManaged public var offices: NSSet
    @NSManaged public var teams: NSSet
    @NSManaged public var idLocal: String

    init(companyName: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Company", in: CoreManager.shared.coreManagerContext)!
        super.init(entity: entity, insertInto: CoreManager.shared.coreManagerContext)
        self.name = companyName
        self.idLocal = UUID().uuidString
    }

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    @nonobjc public func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }
}
