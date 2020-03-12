//
//  Company.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 05.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation
import CoreData

class Company: NSManagedObject {

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

extension Company: TableViewFirstColumnProtocol {
    @objc dynamic public var displayNameForTableView: String {
        return name
    }
    
    func loadAllRelationShipObjetcsBy(typeOfObject type: String) -> [TableViewFirstColumnProtocol] {
        let selectedElement = PickerElement.selected(string: type)
        switch selectedElement {
        case .offices:
            return self.offices.allObjects as! [TableViewFirstColumnProtocol]
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
        switch selected {
        case PickerElement.offices.rawValue:
            return self.offices.allObjects as! [TableViewFirstColumnProtocol]
        case PickerElement.teams.rawValue:
            return self.teams.allObjects as! [TableViewFirstColumnProtocol]
        default:
            fatalError("wrong element")
        }
    }

    func addNewElement(element: TableViewFirstColumnProtocol) {
        if element is Office {
            addNewOffice(newOffice: element as! Office)
        } else if element is Team {
            addNewTeam(newTeam: element as! Team)
        } else {
            fatalError("element no found")
        }
    }

    private func addNewOffice(newOffice: Office) {
        let mutableCopy = self.offices.mutableCopy() as! NSMutableSet
        mutableCopy.add(newOffice)
        self.offices = mutableCopy
        CoreManager.shared.saveContext()
    }

    private func addNewTeam(newTeam: Team) {
        let mutableCopy = self.teams.mutableCopy() as! NSMutableSet
        mutableCopy.add(newTeam)
        self.offices = mutableCopy
        CoreManager.shared.saveContext()
    }
}
