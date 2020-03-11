//
//  MainVC.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 04.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class MainVC: NSViewController {

    @IBOutlet weak var relationShipButton: NSButton!
    @IBOutlet fileprivate weak var userNameTextField: NSTextField!
    @objc dynamic fileprivate var arrayOfElements = [TableViewFirstColumnProtocol]()
    var selectedElement: TableViewFirstColumnProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        HistoryManager.shared.currentObject = PickerElement.company
        arrayOfElements = CoreManager.shared.getAllCompany()
        relationShipButton.title = arrayOfElements.first!.arrayOfRelationShip().first!
    }
    
    @IBAction func didTapAddNewUserButton(_ sender: Any) {
        switch HistoryManager.shared.currentObject {
        case .company:
            arrayOfElements.append(Company(companyName: userNameTextField.stringValue))
        case .offices:
            let newElement = Office.init(officeName: userNameTextField.stringValue, address: "Karazina 2")
            selectedElement?.addNewElement(element: newElement)
            arrayOfElements.append(newElement)
        case .rooms:
            break
        default:
            fatalError("not found")
        }
    }
    
    @IBAction func saveDataToCoreData(_ sender: Any) {
        CoreManager.shared.saveContext()
    }

    @IBAction func didTapRealtionShipButton(_ sender: NSButtonCell) {
        guard let select = selectedElement else {return}
        arrayOfElements = select.choosed(selected: sender.title)
        HistoryManager.shared.addNewObject(newObj: select)
        HistoryManager.shared.currentObject = PickerElement.selected(string: sender.title)
        guard !arrayOfElements.isEmpty else {return}
        relationShipButton.title = arrayOfElements.first!.arrayOfRelationShip().first!
    }
}

extension MainVC: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        self.selectedElement = arrayOfElements[row]
        return true
    }
}
