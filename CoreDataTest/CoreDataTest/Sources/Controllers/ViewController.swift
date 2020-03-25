//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 04.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak fileprivate var colorView: NSColorWell!
    @IBOutlet weak fileprivate var layersTableView: NSTableView!
    @IBOutlet weak fileprivate var rootView: RootView!
    @IBOutlet weak fileprivate var switchDrawOrClear: NSSwitch!
    @IBOutlet weak fileprivate var sliderBrashSize: NSSlider!
    
    @objc dynamic fileprivate var arrayOfLayers = [LayerModel]()
    fileprivate let colorPicker = NSColorPickerTouchBarItem(identifier: .colorLabelItem)
    fileprivate var selectedRowLayer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker.action = #selector(selectedColor(_:))
        //observer for keyboard
        NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.keyDown, handler: myKeyDownEvent)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(tableViewChengeSelectRow),
                                               name: NSTableView.didUpdateTrackingAreasNotification,
                                               object: nil)
        setupUI()
    }
    
    //MARK: - IBActions
    @IBAction func setNewBrashColor(_ sender: NSColorWell) {
        colorPicker.color = sender.color
        if selectedRowLayer < arrayOfLayers.count {
            arrayOfLayers[selectedRowLayer].view.brashColor = sender.color
        }
    }
    
    @IBAction func saveToDesktop(_ sender: Any) {
        rootView.saveSelf()
    }
    
    @IBAction func checkBoxTapped(_ sender: NSButton) {
        let index = layersTableView.row(for: sender)
        
        if sender.state == .off {
            arrayOfLayers[index].isHideLayer = true
            arrayOfLayers[index].view.isHidden = true
        } else {
            arrayOfLayers[index].isHideLayer = false
            arrayOfLayers[index].view.isHidden = false
        }
    }
    
    @IBAction func addNewLayer(_ sender: Any) {
        let layerModel = LayerModel(frame: rootView.frame)
        rootView.addSubview(layerModel.view)
        arrayOfLayers.append(layerModel)
        layerModel.view.widthAnchor.constraint(equalTo: rootView.widthAnchor).isActive = true
        layerModel.view.heightAnchor.constraint(equalTo: rootView.heightAnchor).isActive = true
    }
    
    @IBAction func sliderChangeValue(_ sender: NSSlider) {
        guard layersTableView.selectedRow >= 0 else {return}
        arrayOfLayers[layersTableView.selectedRow].view.brashSize = CGFloat(sender.intValue)
    }
    
    //MARK: - ovveride mouse function
    override func mouseDown(with event: NSEvent) {
        if switchDrawOrClear.state == .on {
            guard layersTableView.selectedRow >= 0 else {return}
            let point = self.view.convert(event.locationInWindow, to: arrayOfLayers[layersTableView.selectedRow].view)
            arrayOfLayers[layersTableView.selectedRow].view.lastPoint = point
        } else {
            guard layersTableView.selectedRow >= 0 else {return}
            let point = self.view.convert(event.locationInWindow, to: arrayOfLayers[layersTableView.selectedRow].view)
            arrayOfLayers[layersTableView.selectedRow].view.clear(atPoint: point)
        }
    }
    
    override func mouseDragged(with event: NSEvent) {
        if switchDrawOrClear.state == .on {
            guard layersTableView.selectedRow >= 0 else {return}
            let point = self.view.convert(event.locationInWindow, to: arrayOfLayers[layersTableView.selectedRow].view)
            arrayOfLayers[layersTableView.selectedRow].view.addPoint(point: point)
        } else {
            guard layersTableView.selectedRow >= 0 else {return}
            let point = self.view.convert(event.locationInWindow, to: arrayOfLayers[layersTableView.selectedRow].view)
            arrayOfLayers[layersTableView.selectedRow].view.clear(atPoint: point)
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        layersTableView.reloadData()
    }
    
    //MARK: - keyboard shortcut
    fileprivate func myKeyDownEvent(event: NSEvent) -> NSEvent?
    {
        let modifierFlags = event.modifierFlags
        if modifierFlags.contains(NSEvent.ModifierFlags.command) && event.keyCode == 6 && layersTableView.selectedRow >= 0 {
            arrayOfLayers[layersTableView.selectedRow].view.removeLastLayer()
            return nil
        }
        return event
    }
    
    //MARK: - keyboard shortcut
    @objc fileprivate func tableViewChengeSelectRow() {
        if layersTableView.selectedRow >= 0 && selectedRowLayer != layersTableView.selectedRow {
            selectedRowLayer = layersTableView.selectedRow
        }
        layersTableView.selectRowIndexes(IndexSet.init(integer: selectedRowLayer),
                                         byExtendingSelection: false)
    }
    
    //other function
    fileprivate func setupUI() {
        addNewLayer(self)//- bug user can't resize window
        colorView.color = arrayOfLayers[selectedRowLayer].view.brashColor
        sliderBrashSize.intValue = Int32(arrayOfLayers[selectedRowLayer].view.brashSize)
        colorPicker.color = arrayOfLayers[selectedRowLayer].view.brashColor
    }
}

extension ViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "LayerCell"), owner: self) as? NSTableCellView
        (cell?.subviews[0] as? NSTextField)?.stringValue = arrayOfLayers[row].layerName
        if arrayOfLayers[row].isHideLayer {
            (cell?.subviews[1] as? NSButton)?.state = .off
        } else {
            (cell?.subviews[1] as? NSButton)?.state = .on
        }
        (cell?.subviews[2] as? NSImageView)?.image = arrayOfLayers[row].previewImage
        return cell
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        if row >= 0 {
            selectedRowLayer = row
            colorView.color = arrayOfLayers[selectedRowLayer].view.brashColor
            sliderBrashSize.intValue = Int32(arrayOfLayers[selectedRowLayer].view.brashSize)
            colorPicker.color = arrayOfLayers[selectedRowLayer].view.brashColor
        }
        return true
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
          return colorPicker
        default:
          return nil
        }
    }
    
    @objc fileprivate func selectedColor(_ sender: Any) {
        if let colorPicker = sender as? NSColorPickerTouchBarItem {
            guard layersTableView.selectedRow >= 0 else {return}
            arrayOfLayers[layersTableView.selectedRow].view.brashColor = colorPicker.color
            colorView.color = arrayOfLayers[selectedRowLayer].view.brashColor
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
