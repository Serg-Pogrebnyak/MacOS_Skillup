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
    
    init(frame: NSRect) {
        self.layerName = "New Layer"
        self.view = CustomView(frame: frame)
        self.isHideLayer = false
    }
    
}
