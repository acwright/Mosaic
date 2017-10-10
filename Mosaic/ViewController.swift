//
//  PickerViewController.swift
//  Mosaic
//
//  Created by Aaron Wright on 1/19/15.
//  Copyright (c) 2015 Aaron Wright. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var gridView: GridView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var smallButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var largeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gridView.image = self.imageView.image
        self.gridView.size = GridView.GridViewSize.Small
        
        self.loadCamera(self)
    }

    @IBAction func size(_ sender: UIButton) {
        self.smallButton.backgroundColor = UIColor.darkGray
        self.mediumButton.backgroundColor = UIColor.darkGray
        self.largeButton.backgroundColor = UIColor.darkGray
        
        if sender == self.smallButton {
            self.smallButton.backgroundColor = UIColor.lightGray
            self.gridView.size = GridView.GridViewSize.Small
        }
        if sender == self.mediumButton {
            self.mediumButton.backgroundColor = UIColor.lightGray
            self.gridView.size = GridView.GridViewSize.Medium
        }
        if sender == self.largeButton {
            self.largeButton.backgroundColor = UIColor.lightGray
            self.gridView.size = GridView.GridViewSize.Large
        }
    }
    
    @IBAction func swap(_ sender: AnyObject) {
        self.gridView.colored = !self.gridView.colored
    }
    
    @IBAction func loadCamera(_ sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        self.present(pickerController, animated: true, completion: nil)
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        self.imageView.image = image
        self.gridView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
