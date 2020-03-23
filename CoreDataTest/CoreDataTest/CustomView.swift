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
    var brashColor = NSColor.red.cgColor
    
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
        shapeLayer.strokeColor = brashColor
        
        self.layer?.addSublayer(shapeLayer)
    }
    
    func removeLatLayer() {
        self.layer?.sublayers?.removeLast()
    }
}
