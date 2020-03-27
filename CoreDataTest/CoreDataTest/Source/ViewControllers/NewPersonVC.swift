//
//  NewPersonVC.swift
//  CoreDataTest
//
//  Created by Sergey Pohrebnuak on 18.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class NewPersonVC: NSViewController {

    var callback: ((Employee) -> Void)?

    @IBOutlet weak fileprivate var personName: NSTextField!

    @IBAction func didTapCreateButton(_ sender: Any) {
        callback?(Employee(employeeName: personName.stringValue))
        self.view.window?.close()
    }
    
}
