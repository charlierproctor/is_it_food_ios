//
//  MainVC.swift
//  ToEatOrNotToEat
//
//  Created by Charlie Proctor on 1/22/15.
//  Copyright (c) 2015 Pushbyte Development Group. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func constructImagePickerController()->UIImagePickerController {
        var picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            picker.sourceType = .Camera
            picker.cameraDevice = .Front
            picker.showsCameraControls = true
        } else {
            picker.sourceType = .PhotoLibrary
        }
        return picker
    }
    @IBAction func checkButtonAction(sender: AnyObject) {
        presentViewController(constructImagePickerController(), animated: true, completion: nil)
    }
    
    @IBAction func swipeLeft(sender: AnyObject) {
        presentViewController(constructImagePickerController(), animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        answerLabel.text = "No"
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

