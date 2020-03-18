//
//  CreateNewTeamViewController.swift
//  CoreDataTest
//
//  Created by Sergey Pohrebnuak on 18.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class CreateNewTeamViewController: NSViewController {
    
    var callback: ((Team) -> Void)?

    @IBOutlet weak var teamName: NSTextField!

    @IBAction func didTapCreateButton(_ sender: Any) {
        callback?(Team(teamName: teamName.stringValue))
        self.view.window?.close()
    }
    
}
