//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 04.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var customView: CustomView!
    @IBOutlet weak var sliderBrashSize: NSSlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderBrashSize.intValue = Int32(customView.brashSize)
        NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.keyDown, handler: myKeyDownEvent)
    }
    
    override func mouseDown(with event: NSEvent) {
        customView.lastPoint = event.locationInWindow
    }
    
    override func mouseDragged(with event: NSEvent) {
        customView.addPoint(point: event.locationInWindow)
    }
    
    @IBAction func sliderChangeValue(_ sender: NSSlider) {
        customView.brashSize = CGFloat(sender.intValue)
    }
    
    func myKeyDownEvent(event: NSEvent) -> NSEvent?
    {
        let modifierFlags = event.modifierFlags
        if modifierFlags.contains(NSEvent.ModifierFlags.command) && event.keyCode == 6 {
            self.customView.removeLatLayer()
            return nil
        }
        return event
    }

}

