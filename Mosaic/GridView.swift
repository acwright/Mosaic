//
//  GridView.swift
//  Mosaic
//
//  Created by Aaron Wright on 1/19/15.
//  Copyright (c) 2015 Aaron Wright. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    enum GridViewSize {
        case Small
        case Medium
        case Large
    }
    
    var divisions: CGFloat = 10.0
    var image: UIImage? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var size: GridViewSize = GridViewSize.Small {
        didSet {
            switch self.size {
            case GridViewSize.Small:
                self.divisions = 10.0
            case GridViewSize.Medium:
                self.divisions = 25.0
            case GridViewSize.Large:
                self.divisions = 50.0
            }
            
            self.setNeedsDisplay()
        }
    }
    
    var colored: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    func drawGrid() {
        let width = self.bounds.width
        let height = self.bounds.height
        
        let multiplier = self.bounds.size.width / self.divisions
        
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setStrokeColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        ctx.setLineWidth(1.0)
        
        for i in 0..<Int(self.divisions) {
            ctx.move(to: CGPoint(x: CGFloat(i) * multiplier, y: 0))
            ctx.addLine(to: CGPoint(x: CGFloat(i) * multiplier, y: height))
            ctx.strokePath()
        }
        
        for i in 0..<Int(self.divisions) {
            ctx.move(to: CGPoint(x: 0, y: CGFloat(i) * multiplier))
            ctx.addLine(to: CGPoint(x: width, y: CGFloat(i) * multiplier))
            ctx.strokePath()
        }
    }
    
    func drawColors() {
        if let image = self.image {
            let width = self.bounds.width / self.divisions
            let height = self.bounds.height / self.divisions
            let imageWidth = image.size.width / self.divisions
            let imageHeight = image.size.height / self.divisions
            
            let imageMultiplier = image.size.width / self.divisions
            let multiplier = self.bounds.size.width / self.divisions
            
            let ctx = UIGraphicsGetCurrentContext()!
            
            for i in 0..<Int(self.divisions) {
                for j in 0..<Int(self.divisions) {
                    let rect = CGRect(x: CGFloat(i) * multiplier, y: CGFloat(j) * multiplier, width: width, height: height)
                    let imageRect = CGRect(x: CGFloat(i) * imageMultiplier, y: CGFloat(j) * imageMultiplier, width: imageWidth, height: imageHeight)
                    
                    if let portion = image.portionOfImage(rect: imageRect) {
                        ctx.setFillColor(portion.averageColor().cgColor)
                        ctx.fill(rect)
                    }
                }
            }
        }
    }

    override func draw(_ rect: CGRect) {
        if self.colored {
            self.drawColors()
        } else {
            self.drawGrid()
        }
    }

}
