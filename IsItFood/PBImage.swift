//
//  PBImage.swift
//  IsItFoodTests
//
//  Created by Charlie Proctor on 1/23/15.
//  Copyright (c) 2015 Pushbyte Development Group. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func cropToSquare()->UIImage {
        var cropped:UIImage = self
        let width = size.width
        let height = size.height
        if (width != height) {
            var newDimension = min(width, height);
            var widthOffset:CGFloat = (width - newDimension) / 2;
            var heightOffset:CGFloat = (height - newDimension) / 2;
            
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(newDimension, newDimension), false, 0)
            drawAtPoint(CGPointMake(-widthOffset, -heightOffset), blendMode: kCGBlendModeCopy, alpha: 1)
            
            cropped = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
        }
        return cropped
    }
}