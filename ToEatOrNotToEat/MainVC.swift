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

    @IBAction func checkButtonAction(sender: AnyObject) {
        var picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        picker.cameraDevice = .Front
        picker.showsCameraControls = true
        self.presentViewController(picker, animated: true, completion: nil)
    }

}

