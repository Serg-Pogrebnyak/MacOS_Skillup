//
//  NewRoomVC.swift
//  CoreDataTest
//
//  Created by Sergey Pohrebnuak on 18.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class NewRoomVC: NSViewController {

    var callback: ((Room) -> Void)?

    @IBOutlet weak fileprivate var roomName: NSTextField!

    @IBAction func didTapCreateButton(_ sender: Any) {
        callback?(Room(roomNumber: roomName.stringValue))
        self.view.window?.close()
    }
    
}
