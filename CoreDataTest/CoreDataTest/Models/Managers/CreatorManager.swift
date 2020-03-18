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
    
    func createNewTeam(callback:@escaping (Team) -> Void) {
        let storyboard = NSStoryboard(name: "CustomWindow",bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "CreateNewTeamVC") as? CreateNewTeamViewController
        vc?.callback = callback
        NewOfficeUIModel.shared.showVCForNewOffice(vc: vc!)
    }
}
