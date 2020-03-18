//
//  TestWindowController.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 13.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class TestWindowController: NSWindowController, NSWindowDelegate {

    weak var deleagteCloseWindow: UserDismissCreateNewObjectDelegate?

    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.minSize = NSSize(width: 200, height: 200)
        self.window?.maxSize = NSSize(width: 200, height: 200)
    }

    func windowWillClose(_ notification: Notification) {
        deleagteCloseWindow?.windowWillClose()
    }

}
