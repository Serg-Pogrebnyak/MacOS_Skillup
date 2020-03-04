//
//  MainVC.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 04.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class MainVC: NSViewController {

    @IBOutlet fileprivate weak var tableView: NSTableView!
    @IBOutlet fileprivate weak var userNameTextField: NSTextField!
    fileprivate var arrayOfUsers = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapAddNewUserButton(_ sender: Any) {
        arrayOfUsers.append(User.init(userName: userNameTextField.stringValue))
        tableView.reloadData()
    }
}

extension MainVC: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return arrayOfUsers.count
    }

    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {

        let item = arrayOfUsers[row]

        if tableColumn == tableView.tableColumns[0] {
            return item.name
        }

        return nil
    }

    func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "UserNameColumn"), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = object as! String
        }
    }
}
