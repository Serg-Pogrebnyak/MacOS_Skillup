//
//  CreateNewOfficeViewController.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 13.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class CreateNewOfficeViewController: NSViewController {

    var callback: ((Office) -> Void)?

    @IBOutlet weak fileprivate var officeName: NSTextField!
    @IBOutlet weak fileprivate var officeAddress: NSTextField!

    @IBAction func didTapCreateButton(_ sender: Any) {
        callback?(Office(officeName: officeName.stringValue, address: officeAddress.stringValue))
        self.view.window?.close()
    }

}
