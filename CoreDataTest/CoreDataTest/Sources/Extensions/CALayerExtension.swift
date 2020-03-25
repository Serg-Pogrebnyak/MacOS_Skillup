//
//  CALayerExtension.swift
//  CoreDataTest
//
//  Created by Sergey Pohrebnuak on 25.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

extension CALayer {
    
    func colorOfPointClear(point:CGPoint) -> Bool {

        var pixel: [CUnsignedChar] = [0, 0, 0, 0]

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)

        context!.translateBy(x: -point.x, y: -point.y)

        self.render(in: context!)

        let red: CGFloat   = CGFloat(pixel[0]) / 255.0
        let green: CGFloat = CGFloat(pixel[1]) / 255.0
        let blue: CGFloat  = CGFloat(pixel[2]) / 255.0
        let alpha: CGFloat = CGFloat(pixel[3]) / 255.0

        let color = NSColor(red:red, green: green, blue:blue, alpha:alpha)

        return color != NSColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
}
