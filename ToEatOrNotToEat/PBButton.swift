//
//  PBButton.swift
//  ToEatOrNotToEat
//
//  Created by Charlie Proctor on 1/22/15.
//  Copyright (c) 2015 Pushbyte Development Group. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class PBButton: UIButton {
    
    @IBInspectable var topInset: CGFloat = 12 {
        didSet {
            contentEdgeInsets.top = topInset
        }
    }
    @IBInspectable var bottomInset: CGFloat = 12 {
        didSet {
            contentEdgeInsets.bottom = bottomInset
        }
    }
    @IBInspectable var leftInset: CGFloat = 20 {
        didSet {
            contentEdgeInsets.left = leftInset
        }
    }
    @IBInspectable var rightInset: CGFloat = 20 {
        didSet {
            contentEdgeInsets.right = rightInset
        }
    }
    @IBInspectable var borderThickness: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderThickness
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.blackColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    @IBInspectable var roundedCorners: Bool = false {
        didSet {
            if roundedCorners {
                layer.cornerRadius = frame.size.height / 2
            }
        }
    }
    @IBInspectable var titleColor: UIColor = UIColor.blackColor() {
        didSet {
            setTitleColor(titleColor, forState: UIControlState.Normal)
        }
    }
    @IBInspectable var bgColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.backgroundColor = bgColor.CGColor
        }
    }
    
    // allow IB to render appearance of button
    override func prepareForInterfaceBuilder() {
        contentEdgeInsets.top = topInset
        contentEdgeInsets.bottom = bottomInset
        contentEdgeInsets.left = leftInset
        contentEdgeInsets.right = rightInset
        layer.borderWidth = borderThickness
        layer.borderColor = borderColor.CGColor
        setTitleColor(titleColor, forState: UIControlState.Normal)
        layer.backgroundColor = bgColor.CGColor
        if roundedCorners {
            layer.cornerRadius = frame.size.height / 2
        }
    }
    
}
