//
//  MainVC.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 04.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class MainVC: NSViewController {

    @IBOutlet weak var myTableView: NSTableView!
    @IBOutlet fileprivate weak var userNameTextField: NSTextField!
    @objc dynamic fileprivate var arrayOfElements = [TableViewFirstColumnProtocol]()
    var selectedElement: TableViewFirstColumnProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        HistoryManager.shared.currentObject = PickerElement.company
        arrayOfElements = CoreManager.shared.getAllCompany()
        
        updateUI()
    }
    
    @IBAction func didTapAddNewUserButton(_ sender: Any) {
        switch HistoryManager.shared.currentObject {
        case .company:
            arrayOfElements.append(Company(companyName: userNameTextField.stringValue))
        default:
            fatalError("not found")
        }
        userNameTextField.stringValue = ""
        updateUI()
    }

    @IBAction func saveDataToCoreData(_ sender: Any) {
        CoreManager.shared.saveContext()
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        defer {
            updateUI()
        }
        guard let lastElement = HistoryManager.shared.back() else {//if no element should load start list in this case it's all list of company (like entrance point)
            arrayOfElements = CoreManager.shared.getAllCompany()
            return
        }

        arrayOfElements = lastElement.loadAllRelationShipObjetcsBy(typeOfObject: HistoryManager.shared.currentObject.rawValue)
    }

    func updateUI() {
        guard !arrayOfElements.isEmpty else {
            myTableView.menu = nil
            return
        }
        myTableView.menu = createContextMenuItems()
    }

    func createContextMenuItems() -> NSMenu {
        let selectedElement = arrayOfElements.first!
        let contextMenu = NSMenu()
        contextMenu.delegate = self
        
        let arrayOfRelationShip = selectedElement.arrayOfRelationShip()
        for title in arrayOfRelationShip {
            let newMenuItem = NSMenuItem(title: title, action: #selector(didTapOnButton(_:)), keyEquivalent: "")
            contextMenu.addItem(newMenuItem)
        }
        
        contextMenu.addItem(NSMenuItem.separator())
        
        let arrayOfNewButton = selectedElement.getMenuForNewItems()
        for title in arrayOfNewButton {
            let newMenuItem = NSMenuItem(title: title, action: #selector(didTapOnButtonCreateNew(_:)), keyEquivalent: "")
            contextMenu.addItem(newMenuItem)
        }
        return contextMenu
    }
    
    @objc func didTapOnButtonCreateNew(_ sender: NSMenuItem) {
        defer {
            updateUI()
        }

        guard myTableView.clickedRow >= 0 else {return}
        selectedElement = arrayOfElements[myTableView.clickedRow]
        selectedElement?.handleTapOnCreateNew(selected: sender.title)
    }
    


    @objc func didTapOnButton(_ sender: NSMenuItem) {
        defer {
            updateUI()
        }

        guard myTableView.clickedRow >= 0 else {return}
        selectedElement = arrayOfElements[myTableView.clickedRow]
        guard !HistoryManager.shared.selectedRelationshipSameToPrevious(stringRelationship: sender.title) else {backButtonTapped(self); return}

        arrayOfElements = selectedElement!.choosed(selected: sender.title)
        HistoryManager.shared.addNewObject(newObj: selectedElement!)//should be only first
        HistoryManager.shared.currentObject = PickerElement.selected(string: sender.title)//should be only second, don't change because it can broke logic
    }
}

extension MainVC: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        self.selectedElement = arrayOfElements[row]
        return true
    }
}

extension MainVC: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
        guard myTableView.clickedRow < 0 else {return}
        menu.cancelTracking()
    }
}
