//
//  UIImage+Circular.swift
//  TwitterVideoDownloader
//
//  Created by Mo Ahmad on 11/01/2020.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import UIKit

extension UIImage {
    func roundedImage() -> UIImage {
        let imageView: UIImageView = UIImageView(image: self)
        let layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = imageView.frame.width / 2
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundedImage!
    }
}

