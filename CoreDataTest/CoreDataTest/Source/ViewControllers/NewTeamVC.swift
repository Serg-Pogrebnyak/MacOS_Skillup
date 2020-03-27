//
//  NewTeamVC.swift
//  CoreDataTest
//
//  Created by Sergey Pohrebnuak on 18.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class NewTeamVC: NSViewController {
    
    var callback: ((Team) -> Void)?

    @IBOutlet weak fileprivate var teamName: NSTextField!

    @IBAction func didTapCreateButton(_ sender: Any) {
        callback?(Team(teamName: teamName.stringValue))
        self.view.window?.close()
    }
    
}
