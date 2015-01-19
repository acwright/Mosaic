// Playground - noun: a place where people can play

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

let spaceURL = NSURL(string: "http://upload.wikimedia.org/wikipedia/commons/c/c3/Aurora_as_seen_by_IMAGE.PNG")
let spaceData = NSData(contentsOfURL: spaceURL!)
var img = UIImage(data: spaceData!)

img!.averageColor()
img!.portionOfImage(CGRectMake(10, 10, 100, 100))!.averageColor()

let mountainURL = NSURL(string: "http://upload.wikimedia.org/wikipedia/commons/6/68/El_Capitan%2C_Yosemite._%285742414416%29.jpg")
let mountainData = NSData(contentsOfURL: mountainURL!)
img = UIImage(data: mountainData!)

img!.averageColor()
img!.portionOfImage(CGRectMake(120, 590, 100, 100))!.averageColor()