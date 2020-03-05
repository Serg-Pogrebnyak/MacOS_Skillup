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
    @objc dynamic fileprivate var arrayOfElements = [TableViewFirstColumnProtocol]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapAddNewUserButton(_ sender: Any) {
        arrayOfElements.append(Company(companyName: userNameTextField.stringValue))
        tableView.reloadData()
    }
    
}
