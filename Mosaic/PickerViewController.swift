//
//  PickerViewController.swift
//  Mosaic
//
//  Created by Aaron Wright on 1/19/15.
//  Copyright (c) 2015 Aaron Wright. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var gridView: GridView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var smallButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var largeButton: UIButton!
    
    var done: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gridView.image = self.imageView.image
        self.gridView.size = GridView.GridViewSize.Small
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !self.done {
            self.loadCamera()
            self.done = true
        }
    }

    @IBAction func size(sender: UIButton) {
        self.smallButton.backgroundColor = UIColor.darkGrayColor()
        self.mediumButton.backgroundColor = UIColor.darkGrayColor()
        self.largeButton.backgroundColor = UIColor.darkGrayColor()
        
        if sender == self.smallButton {
            self.smallButton.backgroundColor = UIColor.lightGrayColor()
            self.gridView.size = GridView.GridViewSize.Small
        }
        if sender == self.mediumButton {
            self.mediumButton.backgroundColor = UIColor.lightGrayColor()
            self.gridView.size = GridView.GridViewSize.Medium
        }
        if sender == self.largeButton {
            self.largeButton.backgroundColor = UIColor.lightGrayColor()
            self.gridView.size = GridView.GridViewSize.Large
        }
    }
    
    @IBAction func swap(sender: AnyObject) {
        self.gridView.colored = !self.gridView.colored
    }
    
    func loadCamera() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        //pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        //pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Photo
        
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as UIImage
        
        self.imageView.image = image
        self.gridView.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

}
