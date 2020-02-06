//
//  UIImage+Circular.swift
//  TwitterVideoDownloader
//
//  Created by Mo Ahmad on 11/01/2020.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import UIKit

extension UIImageView {
    func makeImageCircular() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2
    }
}

