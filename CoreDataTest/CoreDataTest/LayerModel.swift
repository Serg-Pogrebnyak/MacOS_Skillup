//
//  LayerModel.swift
//  CoreDataTest
//
//  Created by Sergey Pohrebnuak on 24.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation
import Cocoa

class LayerModel: NSObject {
    @objc dynamic var layerName: String
    var view: CustomView
    var isHideLayer: Bool
    var previewImage: NSImage {
        let mutuableCopy = view//-bug can't create copy of NSView
        mutuableCopy.isHidden = false
        let mySize = mutuableCopy.bounds.size
        let imgSize = NSMakeSize( mySize.width, mySize.height)
        
        let bir = mutuableCopy.bitmapImageRepForCachingDisplay(in: mutuableCopy.bounds)!
        bir.size = imgSize
        
        mutuableCopy.cacheDisplay(in: mutuableCopy.bounds, to: bir)
        
        let image = NSImage(size: imgSize)
        image.addRepresentation(bir)
        mutuableCopy.isHidden = self.isHideLayer
        return image
    }
    
    init(frame: NSRect) {
        self.layerName = "New Layer"
        
        self.view = CustomView(frame: NSRect.init(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        self.isHideLayer = false
    }
    
}
