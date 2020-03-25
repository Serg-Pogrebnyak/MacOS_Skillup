//
//  RootView.swift
//  CoreDataTest
//
//  Created by Sergey Pohrebnuak on 23.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class RootView: NSView {
    func saveSelf() {
        let mySize = self.bounds.size
        let imgSize = NSMakeSize( mySize.width, mySize.height )
        
        let bir = self.bitmapImageRepForCachingDisplay(in: self.bounds)!
        bir.size = imgSize
        
        self.cacheDisplay(in: self.bounds, to: bir)
        
        let image = NSImage(size: imgSize)
        image.addRepresentation(bir)
        
        let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
        let destinationURL = desktopURL.appendingPathComponent("my-image.png")
        
        if image.pngWrite(to: destinationURL, options: .atomic) {
            print("💾 saved")
        } else {
            print("☎️ error saved")
        }
    }
}
