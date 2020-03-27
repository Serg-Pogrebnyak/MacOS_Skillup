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
    
    private enum CreateNew: String {
        case group = "Create new group"
    }

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

extension Team: TableViewFirstColumnProtocol {

    @objc dynamic public var displayNameForTableView: String {
        return name
    }

    func loadAllRelationShipObjetcsBy(typeOfObject type: String) -> [TableViewFirstColumnProtocol] {
        let selectedElement = PickerElement.selected(string: type)
        switch selectedElement {
        case .groups:
            return self.groups.allObjects as! [TableViewFirstColumnProtocol]
        default:
            fatalError("wrong select")
        }
    }

    func arrayOfRelationShip() -> [String] {
        return [PickerElement.rooms.rawValue, PickerElement.groups.rawValue]
    }

    func choosed(selected: String) -> [TableViewFirstColumnProtocol] {
        let selectedElement = PickerElement.selected(string: selected)
        switch selectedElement {
        case .groups:
            return self.groups.allObjects as! [TableViewFirstColumnProtocol]
        case .rooms:
            return self.rooms.allObjects as! [TableViewFirstColumnProtocol]
        default:
            fatalError("wrong select")
        }
    }

    func getMenuForNewItems() -> [String] {
        return [CreateNew.group.rawValue]
    }
    
    func handleTapOnCreateNew(selected: String) {
        switch selected {
        case CreateNew.group.rawValue:
            addNewGroup()
        default:
            fatalError("element not found")
        }
    }

    private func addNewGroup() {
        CreataNewCorDataObjFactory.shared.createNewGroup { (group) in
            let mutableCopy = self.groups.mutableCopy() as! NSMutableSet
            mutableCopy.add(group)
            self.groups = mutableCopy
            //CoreManager.shared.saveContext()
        }
    }
}
