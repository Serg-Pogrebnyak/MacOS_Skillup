//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 04.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak fileprivate var customView: CustomView!
    @IBOutlet weak fileprivate var sliderBrashSize: NSSlider!
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

extension ViewController: NSTouchBarDelegate {
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .travelBar
        touchBar.defaultItemIdentifiers = [.colorLabelItem]
        touchBar.customizationAllowedItemIdentifiers = [.colorLabelItem]
        return touchBar
    }
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case .colorLabelItem:
          let colorPicker = NSColorPickerTouchBarItem(identifier: identifier)
          colorPicker.action = #selector(selectedColor(_:))
          return colorPicker
        default:
          return nil
        }
    }
    
    @objc fileprivate func selectedColor(_ sender: Any) {
        if let colorPicker = sender as? NSColorPickerTouchBarItem {
            customView.brashColor = colorPicker.color.cgColor
        } else {
            fatalError("wrong sender")
        }
    }
}

extension NSTouchBarItem.Identifier {
    static let colorLabelItem = NSTouchBarItem.Identifier("com.razeware.color")
}

extension NSTouchBar.CustomizationIdentifier {
    static let travelBar = NSTouchBar.CustomizationIdentifier("com.razeware.ViewController.TravelBar")
}
