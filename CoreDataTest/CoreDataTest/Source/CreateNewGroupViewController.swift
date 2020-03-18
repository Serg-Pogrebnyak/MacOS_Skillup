//
//  CreateNewGroupViewController.swift
//  CoreDataTest
//
//  Created by Sergey Pohrebnuak on 18.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class CreateNewGroupViewController: NSViewController {

    var callback: ((Group) -> Void)?

    @IBOutlet weak var groupName: NSTextField!

    @IBAction func didTapCreateButton(_ sender: Any) {
        callback?(Group(groupName: groupName.stringValue))
        self.view.window?.close()
    }
    
}
