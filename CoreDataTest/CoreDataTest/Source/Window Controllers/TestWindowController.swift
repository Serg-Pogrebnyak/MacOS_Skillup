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
        self.window?.minSize = NSSize(width: 400, height: 400)
        self.window?.maxSize = NSSize(width: 400, height: 400)
    }

    func windowWillClose(_ notification: Notification) {
        deleagteCloseWindow?.windowWillClose()
    }

}
