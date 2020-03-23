//
//  RootWindowController.swift
//  CoreDataTest
//
//  Created by Sergey Pohrebnuak on 23.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class RootWindowController: NSWindowController {
    
    override func makeTouchBar() -> NSTouchBar? {
        if self.contentViewController is ViewController {
            return (self.contentViewController as! ViewController).makeTouchBar()
        } else {
            return nil
        }
    }

}
