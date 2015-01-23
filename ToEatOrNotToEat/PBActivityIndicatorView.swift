//
//  PBActivityIndicatorView.swift
//  ToEatOrNotToEat
//
//  Created by Charlie Proctor on 1/23/15.
//  Copyright (c) 2015 Pushbyte Development Group. All rights reserved.
//

import Foundation
import UIKit

/// a class to setup a custom UIActivityIndicatorView with a transparent black UIView background
class PBActivityIndicatorView {
    
    /// the UIActivityIndicatorView (the spinning dialog)
    var activityIndicatorView: UIActivityIndicatorView
    
    /// the UIView to lay over the background content
    var overlay: UIView
    
    /** setup the overlay and the activityIndicatorView */
    init() {
        // set up the overlay -- fullscreen, black, transparent
        overlay = UIView(frame: UIScreen.mainScreen().bounds)
        overlay.backgroundColor = UIColor.blackColor()
        overlay.alpha = 0.5
        
        // set up the activityIndicatorView (white, large)
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activityIndicatorView.hidesWhenStopped = true
        
        // add the activityIndicatorView to the overlay and center it
        overlay.addSubview(activityIndicatorView)
        activityIndicatorView.center = CGPointMake(overlay.frame.size.width / 2, overlay.frame.size.height / 3)
    }
    
    
    // MARK: Show / Hide
    
    /** show the view and start the animation
    :param: superView the UIView on which to overlay the activityIndicatorView */
    func show(superView: UIView){
        superView.addSubview(overlay)
        activityIndicatorView.startAnimating()
    }
    
    /** hide the view and stop the animation */
    func hide(){
        activityIndicatorView.stopAnimating()
        overlay.removeFromSuperview()
    }
    
}