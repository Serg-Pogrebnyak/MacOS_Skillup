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

extension Office: TableViewFirstColumnProtocol {
    @objc dynamic public var displayNameForTableView: String {
        return name
    }
    
    func loadAllRelationShipObjetcsBy(typeOfObject type: String) -> [TableViewFirstColumnProtocol] {
        let selectedElement = PickerElement.selected(string: type)
        switch selectedElement {
        case .rooms:
            return self.rooms.allObjects as! [TableViewFirstColumnProtocol]
        default:
            fatalError("wrong select")
        }
    }

    func arrayOfRelationShip() -> [String] {
        return [PickerElement.rooms.rawValue, PickerElement.company.rawValue]
    }

    func choosed(selected: String) -> [TableViewFirstColumnProtocol] {
        switch selected {
        case PickerElement.rooms.rawValue:
            return self.rooms.allObjects as! [TableViewFirstColumnProtocol]
        default:
            fatalError("wrong element")
        }
    }

    func addNewElement(element: TableViewFirstColumnProtocol) {
        if element is Room {
            addNewRoom(newRoom: element as! Room)
        } else {
            fatalError("element no found")
        }
    }

    private func addNewRoom(newRoom: Room) {
        let mutableCopy = self.rooms.mutableCopy() as! NSMutableSet
        mutableCopy.add(newRoom)
        self.rooms = mutableCopy
        CoreManager.shared.saveContext()
    }
}
