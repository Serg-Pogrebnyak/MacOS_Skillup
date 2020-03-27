//
//  CreatorManager.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 13.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation
import Cocoa

class CreataNewCorDataObjFactory {
    static let shared = CreataNewCorDataObjFactory()

    func createNewOffice(callback:@escaping (Office) -> Void) {
        let storyboard = NSStoryboard(name: "CustomWindow",bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "CreateNewOfficeVC") as? NewOfficeVC
        vc?.callback = callback
        NewOfficeUIModel.shared.showVCForNewOffice(vc: vc!)
    }
    
    func createNewRoom(callback:@escaping (Room) -> Void) {
        let storyboard = NSStoryboard(name: "CustomWindow",bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "CreateNewRoomVC") as? NewRoomVC
        vc?.callback = callback
        NewOfficeUIModel.shared.showVCForNewOffice(vc: vc!)
    }
    
    func createNewTeam(callback:@escaping (Team) -> Void) {
        let storyboard = NSStoryboard(name: "CustomWindow",bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "CreateNewTeamVC") as? NewTeamVC
        vc?.callback = callback
        NewOfficeUIModel.shared.showVCForNewOffice(vc: vc!)
    }
    
    func createNewTeamFromCompany(roomArray: [TableViewFirstColumnProtocol], callback:@escaping (Team) -> Void) {
        let storyboard = NSStoryboard(name: "CustomWindow",bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "CreateNewTeamFromCompanyVC") as? NewTeamFromCompanyVC
        vc?.callback = callback
        vc?.arrayOfElements = roomArray
        NewOfficeUIModel.shared.showVCForNewOffice(vc: vc!)
    }
    
    func createNewGroup(callback:@escaping (Group) -> Void) {
        let storyboard = NSStoryboard(name: "CustomWindow",bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "CreateNewGroupVC") as? NewGroupVC
        vc?.callback = callback
        NewOfficeUIModel.shared.showVCForNewOffice(vc: vc!)
    }
    
    func createNewPerson(callback:@escaping (Employee) -> Void) {
        let storyboard = NSStoryboard(name: "CustomWindow",bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "CreateNewPersonVC") as? NewPersonVC
        vc?.callback = callback
        NewOfficeUIModel.shared.showVCForNewOffice(vc: vc!)
    }
}
