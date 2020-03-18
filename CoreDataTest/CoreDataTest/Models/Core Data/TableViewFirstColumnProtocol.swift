//
//  TableViewFirstColumnProtocol.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 05.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation
import Cocoa

enum PickerElement: String {
    case company
    case offices
    case rooms
    case teams
    case groups
    case persons

    static func selected(string: String) -> Self {
        switch string {
        case PickerElement.company.rawValue:
            return PickerElement.company
        case PickerElement.offices.rawValue:
            return PickerElement.offices
        case PickerElement.teams.rawValue:
            return PickerElement.teams
        case PickerElement.rooms.rawValue:
            return PickerElement.rooms
        case PickerElement.groups.rawValue:
            return PickerElement.groups
        case PickerElement.persons.rawValue:
            return PickerElement.persons
        default:
            fatalError("wrong element")
        }
    }
}

@objc protocol TableViewFirstColumnProtocol {
    var displayNameForTableView: String {get}
    func loadAllRelationShipObjetcsBy(typeOfObject type: String) -> [TableViewFirstColumnProtocol]
    func arrayOfRelationShip() -> [String]
    func choosed(selected: String) -> [TableViewFirstColumnProtocol]
    func getMenuForNewItems() -> [String]
    func handleTapOnCreateNew(selected: String)
}
