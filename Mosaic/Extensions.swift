//
//  Extensions.swift
//  Mosaic
//
//  Created by Aaron Wright on 1/19/15.
//  Copyright (c) 2015 Aaron Wright. All rights reserved.
//

import UIKit

extension UIImage {
    func averageColor() -> UIColor {
        let size = CGSizeMake(1, 1)
        
        UIGraphicsBeginImageContext(size)
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetInterpolationQuality(context, kCGInterpolationMedium)
        
        self.drawInRect(CGRectMake(0, 0, size.width, size.height), blendMode: kCGBlendModeCopy, alpha: 1.0)
        
        let data = CGBitmapContextGetData(context)
        let _data = UnsafePointer<UInt8>(data)
        let red = CGFloat(_data[2]) / 255.0
        let green = CGFloat(_data[1]) / 255.0
        let blue = CGFloat(_data[0]) / 255.0
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        UIGraphicsEndImageContext()
        
        return color
    }
    
    func portionOfImage(rect: CGRect) -> UIImage? {
        let imageRef = CGImageCreateWithImageInRect(self.CGImage, rect)
        let image = UIImage(CGImage: imageRef)
        return image
    }
}
