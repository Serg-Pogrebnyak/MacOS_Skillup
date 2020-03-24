//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 04.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak fileprivate var layersTableView: NSTableView!
    @IBOutlet weak fileprivate var layersView: LayersManager!
    @IBOutlet weak fileprivate var switchDrawOrClear: NSSwitch!
    //@IBOutlet weak fileprivate var customView: CustomView!
    @IBOutlet weak fileprivate var sliderBrashSize: NSSlider!
    @objc dynamic var arrayOfLayers = [CustomView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sliderBrashSize.intValue = Int32(customView.brashSize)
        NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.keyDown, handler: myKeyDownEvent)
    }
    
    override func mouseDown(with event: NSEvent) {
        if switchDrawOrClear.state == .on {
            guard layersTableView.selectedRow >= 0 else {return}
            arrayOfLayers[layersTableView.selectedRow].lastPoint = event.locationInWindow
        } else {
            guard layersTableView.selectedRow >= 0 else {return}
            arrayOfLayers[layersTableView.selectedRow].clear(atPoint: event.locationInWindow)
        }
    }
    
    override func mouseDragged(with event: NSEvent) {
        if switchDrawOrClear.state == .on {
            guard layersTableView.selectedRow >= 0 else {return}
            arrayOfLayers[layersTableView.selectedRow].addPoint(point: event.locationInWindow)
        } else {
            guard layersTableView.selectedRow >= 0 else {return}
            arrayOfLayers[layersTableView.selectedRow].clear(atPoint: event.locationInWindow)
        }
    }
    
    @IBAction func checkBoxTapped(_ sender: NSButton) {
        let index = layersTableView.row(for: sender)
        
        if sender.state == .off {
            arrayOfLayers[index].isHidden = true
        } else {
            arrayOfLayers[index].isHidden = false
        }
    }
    
    @IBAction func addNewLayer(_ sender: Any) {
        let view = CustomView(frame: layersView.frame)
        layersView.addSubview(view)
        arrayOfLayers.append(view)
        view.widthAnchor.constraint(equalTo: layersView.widthAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: layersView.heightAnchor).isActive = true
    }
    
    @IBAction func sliderChangeValue(_ sender: NSSlider) {
        guard layersTableView.selectedRow >= 0 else {return}
        arrayOfLayers[layersTableView.selectedRow].brashSize = CGFloat(sender.intValue)
    }
    
    func myKeyDownEvent(event: NSEvent) -> NSEvent?
    {
        let modifierFlags = event.modifierFlags
        if modifierFlags.contains(NSEvent.ModifierFlags.command) && event.keyCode == 6 && layersTableView.selectedRow >= 0 {
            arrayOfLayers[layersTableView.selectedRow].removeLastLayer()
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
            guard layersTableView.selectedRow >= 0 else {return}
            arrayOfLayers[layersTableView.selectedRow].brashColor = colorPicker.color.cgColor
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
