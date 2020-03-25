//
//  CustomView.swift
//  CoreDataTest
//
//  Created by Sergey Pohrebnuak on 20.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

class CustomView: NSView {
    
    var lastPoint = NSPoint(x: 0, y: 0)
    var brashSize: CGFloat = 5
    var brashColor = NSColor.red
    
    func addPoint(point: CGPoint) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.frame
        let path = CGMutablePath()
        path.move(to: lastPoint)
        path.addLine(to: point)
        lastPoint = point
        
        shapeLayer.path = path
        shapeLayer.lineWidth = brashSize
        shapeLayer.lineCap = .round
        shapeLayer.strokeColor = brashColor.cgColor
        
        self.layer?.addSublayer(shapeLayer)
    }
    
    func removeLastLayer() {
        self.layer?.sublayers?.removeLast()
    }
    
    func clear(atPoint point: NSPoint) {
        guard !(self.layer?.sublayers?.isEmpty ?? true) else {return}
        for index in 0...self.layer!.sublayers!.count-1 {
            var previousLayer: CALayer? = nil
            if index > 0 {
                previousLayer = self.layer!.sublayers![index-1]
            }
            let layer = self.layer!.sublayers![index]
            if layer.colorOfPointClear(point: point) {
                if previousLayer != nil {
                    previousLayer!.sublayers = (previousLayer!.sublayers ?? []) + (layer.sublayers ?? [])
                }
                layer.removeFromSuperlayer()
                return
            }
        }
    }
}

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
