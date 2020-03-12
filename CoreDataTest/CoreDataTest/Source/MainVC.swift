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
    @IBOutlet weak var buttonsStackView: CustomStackOfButtons!
    @IBOutlet fileprivate weak var userNameTextField: NSTextField!
    @objc dynamic fileprivate var arrayOfElements = [TableViewFirstColumnProtocol]()
    var selectedElement: TableViewFirstColumnProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsStackView.delegate = self
        HistoryManager.shared.currentObject = PickerElement.company
        arrayOfElements = CoreManager.shared.getAllCompany()
        buttonsStackView.generateButtonsStack(arrayOfTitle: arrayOfElements.first!.arrayOfRelationShip())
    }
    
    @IBAction func didTapAddNewUserButton(_ sender: Any) {
        switch HistoryManager.shared.currentObject {
        case .company:
            arrayOfElements.append(Company(companyName: userNameTextField.stringValue))
        case .offices:
            guard let select = selectedElement else {return}
            let newElement = Office.init(officeName: userNameTextField.stringValue, address: "Karazina 2")
            select.addNewElement(element: newElement)
            arrayOfElements.append(newElement)
        case .rooms:
            guard let select = selectedElement else {return}
            let newElement = Room.init(roomNumber: userNameTextField.stringValue)
            select.addNewElement(element: newElement)
            arrayOfElements.append(newElement)
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
            buttonsStackView.hideAllButtons()
            return
        }
        buttonsStackView.generateButtonsStack(arrayOfTitle: arrayOfElements.first!.arrayOfRelationShip())
    }
}

extension MainVC: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        self.selectedElement = arrayOfElements[row]
        return true
    }
}

extension MainVC: DidTapOnButtonFromCustomStackOfButtonsDelegate {
    func didTapOnButton(withTitle title: String) {
        defer {
            updateUI()
        }
        guard !HistoryManager.shared.selectedRelationshipSameToPrevious(stringRelationship: title) else {backButtonTapped(self); return}
        guard let select = selectedElement else {return}

        arrayOfElements = select.choosed(selected: title)
        HistoryManager.shared.addNewObject(newObj: select)//should be only first
        HistoryManager.shared.currentObject = PickerElement.selected(string: title)//should be only second, don't change because it can broke logic

    }
}
