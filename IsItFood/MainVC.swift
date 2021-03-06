//
//  MainVC.swift
//  IsItFoodTests
//
//  Created by Charlie Proctor on 1/22/15.
//  Copyright (c) 2015 Pushbyte Development Group. All rights reserved.
//

import UIKit
import Alamofire
import Darwin

class MainVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    lazy var hasChosenAnImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.whiteColor().CGColor
        imageView.layer.backgroundColor = UIColor.greenColor().CGColor
        
        getQuote { (author, text) -> Void in
            self.quoteLabel.text = text
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getQuote(onSuccess:(author:String, text:String)->Void){
        Alamofire.request(.GET, "http://isitfood.herokuapp.com")
            .responseJSON { (_, _, res, _) in
                if let json = res as? [String:String] {
                    onSuccess(author: json["author"]!,text: json["text"]!)
                }
        }
    }
    
    func constructImagePickerController()->UIImagePickerController {
        var picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            picker.sourceType = .Camera
            picker.cameraDevice = .Rear
            picker.showsCameraControls = true
        } else {
            picker.sourceType = .PhotoLibrary
        }
        return picker
    }
    @IBAction func checkButtonAction(sender: AnyObject) {
        presentViewController(constructImagePickerController(), animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        var activityIndicatorView = PBActivityIndicatorView()
        activityIndicatorView.show(view)
        
        picker.dismissViewControllerAnimated(true, completion: {
            if arc4random() % 2 == 0 {
                self.view.backgroundColor = UIColor.greenColor()
                self.answerLabel.text = "YES, IT'S FOOD"
            } else {
                self.view.backgroundColor = UIColor.redColor()
                self.answerLabel.text = "NO, NOT FOOD"
            }
            self.getQuote { (author, text) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.authorLabel.text = author
                    self.quoteLabel.text = text
                })
            }
            if !self.hasChosenAnImage {
                self.hasChosenAnImage = true
                self.quoteLabel.hidden = false
                self.quoteLabel.numberOfLines = 0
                self.authorLabel.hidden = false
                self.answerLabel.font = self.answerLabel.font.fontWithSize(40)
                self.checkButton.setTitle("Check Again", forState: .Normal)
            }
            self.imageView.image = image.cropToSquare()
            activityIndicatorView.hide()
        })
        
    }
}

