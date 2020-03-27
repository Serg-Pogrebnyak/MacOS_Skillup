//
//  TableViewFirstColumnProtocol.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 05.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

@objc protocol TableViewFirstColumnProtocol {
    var displayNameForTableView: String {get}
    func loadAllRelationShipObjetcsBy(typeOfObject type: String) -> [TableViewFirstColumnProtocol]
    func arrayOfRelationShip() -> [String]
    func choosed(selected: String) -> [TableViewFirstColumnProtocol]
    func getMenuForNewItems() -> [String]
    func handleTapOnCreateNew(selected: String)
}
