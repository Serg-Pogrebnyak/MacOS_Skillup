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
    private var stackOfHistoryObjectState = [PickerElement]()

    func addNewObject(newObj: TableViewFirstColumnProtocol) {
        stackOfHistoryObjectState.append(currentObject)
        stackOfHistoryObject.append(newObj)
    }

    func back() -> TableViewFirstColumnProtocol? {
        guard !stackOfHistoryObject.isEmpty else {return nil}
        currentObject = stackOfHistoryObjectState.removeLast()
        stackOfHistoryObject.removeLast()
        if let last = stackOfHistoryObject.last {
            return last
        } else {
            return nil
        }
    }

    func selectedRelationshipSameToPrevious(stringRelationship relationship: String) -> Bool {
        guard let lastObject = stackOfHistoryObjectState.last else {return false}
        let object = PickerElement.selected(string: relationship)
        return object == lastObject
    }
}
