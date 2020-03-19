//
//  CreateNewTeamFromCompanyViewController.swift
//  CoreDataTest
//
//  Created by Sergey Pohrebnuak on 18.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class CreateNewTeamFromCompanyViewController: NSViewController {

    var callback: ((Team) -> Void)?
    
    
    @IBOutlet weak var roomTableView: NSTableView!
    @objc dynamic var arrayOfElements = [TableViewFirstColumnProtocol]()

    @IBOutlet weak var teamName: NSTextField!

    @IBAction func didTapCreateButton(_ sender: Any) {
        if roomTableView!.selectedRow >= 0 {
            let newTeam = Team(teamName: teamName.stringValue)
            let room = arrayOfElements[roomTableView!.selectedRow] as! Room
            var mutuable = room.teams.mutableCopy() as! NSMutableSet
            mutuable.add(newTeam)
            room.teams = mutuable
            
            newTeam.company = room.office.company
            let mutuableRooms = newTeam.rooms.mutableCopy() as! NSMutableSet
            mutuableRooms.add(room)
            newTeam.rooms = mutuableRooms
            callback?(newTeam)
            self.view.window?.close()
        } else {
            print("❌error")
        }
    }
    
}
