//
//  HistoryManager.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 10.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation

class HistoryManager {

    static var shared = HistoryManager()
    var currentObject: PickerElement!

    private var stackOfHistoryObject = [TableViewFirstColumnProtocol]()

    func addNewObject(newObj: TableViewFirstColumnProtocol) {
        stackOfHistoryObject.append(newObj)
    }
}
