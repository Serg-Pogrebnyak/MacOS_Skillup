//
//  CreatorManager.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 13.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation
import Cocoa

class CreatorManager {
    static let shared = CreatorManager()

    func createNewOffice(callback:@escaping (Office) -> Void) {
        let storyboard = NSStoryboard(name: "CustomWindow",bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "CreateNewOfficeVC") as? CreateNewOfficeViewController
        vc?.callback = callback
        NewOfficeUIModel.shared.showVCForNewOffice(vc: vc!)
    }
    
    func createNewRoom(callback:@escaping (Room) -> Void) {
        let storyboard = NSStoryboard(name: "CustomWindow",bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "CreateNewRoomVC") as? CreateNewRoomViewController
        vc?.callback = callback
        NewOfficeUIModel.shared.showVCForNewOffice(vc: vc!)
    }
    
    func createNewTeam(callback:@escaping (Team) -> Void) {
        let storyboard = NSStoryboard(name: "CustomWindow",bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "CreateNewTeamVC") as? CreateNewTeamViewController
        vc?.callback = callback
        NewOfficeUIModel.shared.showVCForNewOffice(vc: vc!)
    }
    
    func createNewTeamFromCompany(roomArray: [TableViewFirstColumnProtocol], callback:@escaping (Team) -> Void) {
        let storyboard = NSStoryboard(name: "CustomWindow",bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "CreateNewTeamFromCompanyVC") as? CreateNewTeamFromCompanyViewController
        vc?.callback = callback
        vc?.arrayOfElements = roomArray
        NewOfficeUIModel.shared.showVCForNewOffice(vc: vc!)
    }
    
    func createNewGroup(callback:@escaping (Group) -> Void) {
        let storyboard = NSStoryboard(name: "CustomWindow",bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "CreateNewGroupVC") as? CreateNewGroupViewController
        vc?.callback = callback
        NewOfficeUIModel.shared.showVCForNewOffice(vc: vc!)
    }
    
    func createNewPerson(callback:@escaping (Employee) -> Void) {
        let storyboard = NSStoryboard(name: "CustomWindow",bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "CreateNewPersonVC") as? CreateNewPersonViewController
        vc?.callback = callback
        NewOfficeUIModel.shared.showVCForNewOffice(vc: vc!)
    }
}
