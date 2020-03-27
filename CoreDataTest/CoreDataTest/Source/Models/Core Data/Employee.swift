//
//  Employee.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 04.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation
import CoreData

class Employee: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var group: Group
    @NSManaged public var idLocal: String

    init(employeeName: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Employee", in: CoreManager.shared.coreManagerContext)!
        super.init(entity: entity, insertInto: CoreManager.shared.coreManagerContext)
        self.name = employeeName
        self.idLocal = UUID().uuidString
    }

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    @nonobjc public func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }
}

extension Employee: TableViewFirstColumnProtocol {

    @objc dynamic public var displayNameForTableView: String {
        return name
    }

    func loadAllRelationShipObjetcsBy(typeOfObject type: String) -> [TableViewFirstColumnProtocol] {
        return []
    }

    func arrayOfRelationShip() -> [String] {
        return [PickerElement.groups.rawValue]
    }

    func choosed(selected: String) -> [TableViewFirstColumnProtocol] {
        return []
    }

    func getMenuForNewItems() -> [String] {
        return []
    }
    
    func handleTapOnCreateNew(selected: String) {
        fatalError("element not found")
    }
}
