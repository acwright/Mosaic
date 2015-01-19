//
//  ViewController.swift
//  Mosaic
//
//  Created by Aaron Wright on 1/19/15.
//  Copyright (c) 2015 Aaron Wright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var zoomLabel: UILabel!
    
    var imageIndex = 0
    var images: [UIImage] = []
    
    var originalImage: UIImage?
    var alteredImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image1 = "http://upload.wikimedia.org/wikipedia/commons/c/c3/Aurora_as_seen_by_IMAGE.PNG"
        let image2 = "http://upload.wikimedia.org/wikipedia/commons/6/68/El_Capitan%2C_Yosemite._%285742414416%29.jpg"
        let image3 = "http://www.theblogismine.com/wp-content/uploads/2011/02/National-Geographic-February-2011-week-2-09.jpg"
        let image4 = "http://free.wallpaperbackgrounds.com/photography/cool/203443-40517.jpg"
        let image5 = "http://sshhii.files.wordpress.com/2011/04/color-grid-colors.jpg"
        
        let imageURLs = [image1, image2, image3, image4, image5]
        
        for urlString in imageURLs {
            if let url = NSURL(string: urlString) {
                if let data = NSData(contentsOfURL: url) {
                    self.images.append(UIImage(data: data)!)
                }
            }
        }
        
        self.loadImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        println("Memory warning!")
    }

    @IBAction func sliderChanged(sender: UISlider) {
        let stepValue = round(sender.value * 10) * 0.1
        
        self.slider.value = stepValue
        
        self.processImage()
    }
    
    @IBAction func swapImage(sender: AnyObject) {
        self.imageIndex++
        
        if imageIndex == images.count {
            self.imageIndex = 0
        }
        
        self.loadImage()
    }
    
    func loadImage() {
        self.originalImage = self.images[self.imageIndex]
        
        self.processImage()
        self.update()
    }
    
    func processImage() {
        let newValue = CGFloat(self.slider.value)
        
        if let originalImage = self.originalImage {
            let width = originalImage.size.width * newValue
            let height = originalImage.size.height * newValue
            
            self.alteredImage = originalImage.portionOfImage(CGRectMake(0, 0, width, height))
            
            self.update()
        }
    }
    
    func update() {
        let value = ((1.0 - self.slider.value) * 10.0) + 1.0
        self.zoomLabel.text = "\(value)x"
        
        if let alteredImage = self.alteredImage {
            self.imageView.image = self.alteredImage
        } else {
            self.imageView.image = self.originalImage
        }
        
        if let image = self.imageView.image {
            self.colorView.backgroundColor = image.averageColor()
        }
    }

}

