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
            default:
                break
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
        
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1.0)
        CGContextSetLineWidth(ctx, 1.0)
        
        for var i: CGFloat = 0; i <= self.divisions; i++ {
            CGContextMoveToPoint(ctx, i * multiplier, 0)
            CGContextAddLineToPoint(ctx, i * multiplier, height)
            CGContextStrokePath(ctx)
        }
        
        for var i: CGFloat = 0; i <= self.divisions; i++ {
            CGContextMoveToPoint(ctx, 0, i * multiplier)
            CGContextAddLineToPoint(ctx, width, i * multiplier)
            CGContextStrokePath(ctx)
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
            
            let ctx = UIGraphicsGetCurrentContext()
            
            for var i: CGFloat = 0; i <= self.divisions; i++ {
                for var j: CGFloat = 0; j <= self.divisions; j++ {
                    let rect = CGRectMake(i * multiplier, j * multiplier, width, height)
                    let imageRect = CGRectMake(i * imageMultiplier, j * imageMultiplier, imageWidth, imageHeight)
                    
                    CGContextSetFillColorWithColor(ctx, image.portionOfImage(imageRect)?.averageColor().CGColor)
                    CGContextFillRect(ctx, rect)
                }
            }
        }
    }

    override func drawRect(rect: CGRect) {
        if self.colored {
            self.drawColors()
        } else {
            self.drawGrid()
        }
    }

}
