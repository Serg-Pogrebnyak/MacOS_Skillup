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
    @objc dynamic fileprivate var arrayOfUsers = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapAddNewUserButton(_ sender: Any) {
        arrayOfUsers.append(User.init(userName: userNameTextField.stringValue))
        tableView.reloadData()
    }
    
}
