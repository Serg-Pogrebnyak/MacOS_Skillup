//
//  Group.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 05.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation
import CoreData

class Group: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var team: Team
    @NSManaged public var persons: NSSet
    @NSManaged public var idLocal: String

    private enum CreateNew: String {
        case person = "Create new person"
    }
    
    init(groupName: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Group", in: CoreManager.shared.coreManagerContext)!
        super.init(entity: entity, insertInto: CoreManager.shared.coreManagerContext)
        self.name = groupName
        self.idLocal = UUID().uuidString
    }

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    @nonobjc public func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }
}

extension Group: TableViewFirstColumnProtocol {

    @objc dynamic public var displayNameForTableView: String {
        return name
    }

    func loadAllRelationShipObjetcsBy(typeOfObject type: String) -> [TableViewFirstColumnProtocol] {
        let selectedElement = PickerElement.selected(string: type)
        switch selectedElement {
        case .persons:
            return self.persons.allObjects as! [TableViewFirstColumnProtocol]
        default:
            fatalError("wrong select")
        }
    }

    func arrayOfRelationShip() -> [String] {
        return [PickerElement.teams.rawValue, PickerElement.persons.rawValue]
    }

    func choosed(selected: String) -> [TableViewFirstColumnProtocol] {
        let selectedElement = PickerElement.selected(string: selected)
        switch selectedElement {
        case .persons:
            return self.persons.allObjects as! [TableViewFirstColumnProtocol]
        default:
            fatalError("wrong select")
        }
    }

    func getMenuForNewItems() -> [String] {
        return [CreateNew.person.rawValue]
    }
    
    func handleTapOnCreateNew(selected: String) {
        switch selected {
        case CreateNew.person.rawValue:
            addNewPerson()
        default:
            fatalError("element not found")
        }
    }

    private func addNewPerson() {
        CreataNewCorDataObjFactory.shared.createNewPerson { (person) in
            let mutableCopy = self.persons.mutableCopy() as! NSMutableSet
            mutableCopy.add(person)
            self.persons = mutableCopy
            //CoreManager.shared.saveContext()
        }
    }
}
