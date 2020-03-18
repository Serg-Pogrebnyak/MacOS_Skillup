//
//  Room.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 05.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation
import CoreData
import Cocoa

class Room: NSManagedObject {
    @NSManaged public var roomNumber: String
    @NSManaged public var teams: NSSet
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

extension Room: TableViewFirstColumnProtocol {
    func handleTapOnCreateNew(selected: String) {
        print("handle")
    }
    
    func getMenuForNewItems() -> [String] {
        return []
    }

    @objc dynamic public var displayNameForTableView: String {
        return roomNumber
    }

    func loadAllRelationShipObjetcsBy(typeOfObject type: String) -> [TableViewFirstColumnProtocol] {
        let selectedElement = PickerElement.selected(string: type)
        switch selectedElement {
        case .teams:
            return self.teams.allObjects as! [TableViewFirstColumnProtocol]
        default:
            fatalError("wrong select")
        }
    }

    func arrayOfRelationShip() -> [String] {
        return [PickerElement.offices.rawValue, PickerElement.teams.rawValue]
    }

    func choosed(selected: String) -> [TableViewFirstColumnProtocol] {
        let selectedElement = PickerElement.selected(string: selected)
        switch selectedElement {
        case .teams:
            return self.teams.allObjects as! [TableViewFirstColumnProtocol]
        default:
            fatalError("wrong select")
        }
    }

    func addNewElement(element: TableViewFirstColumnProtocol) {
        if element is Team {
            addNewTeam(newTeam: element as! Team)
        } else {
            fatalError("element no found")
        }
    }

    private func addNewTeam(newTeam: Team) {
        let mutableCopy = self.teams.mutableCopy() as! NSMutableSet
        mutableCopy.add(newTeam)
        self.teams = mutableCopy
        CoreManager.shared.saveContext()
    }
}
