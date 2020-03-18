//
//  NewOfficeUIModel.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 13.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation
import Cocoa

protocol UserDismissCreateNewObjectDelegate: class {
    func windowWillClose()
}

class NewOfficeUIModel: UserDismissCreateNewObjectDelegate {
    static let shared = NewOfficeUIModel()

    private var controller : NSWindowController?

    func windowWillClose() {
        controller = nil
    }

    private func createNewWindowForCompany(vc: NSViewController) {
        let storyboard = NSStoryboard(name: "CustomWindow",bundle: nil)
        guard let windowController = storyboard.instantiateController(withIdentifier: "TestWindowController") as? TestWindowController else {return}
        windowController.contentViewController = vc
        windowController.showWindow(self)
        windowController.deleagteCloseWindow = self
        controller = windowController
    }

    func showVCForNewOffice(vc: NSViewController) {
        if controller == nil {
            createNewWindowForCompany(vc: vc)
        } else {
            controller?.showWindow(self)
        }
    }
}
