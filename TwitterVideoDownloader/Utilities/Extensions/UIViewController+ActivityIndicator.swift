//
//  UIViewController+ActivityIndicator.swift
//  TwitterVideoDownloader
//
//  Created by Mo Ahmad on 27/01/2020.
//  Copyright © 2020 Ahmad, Mohammed (UK - London). All rights reserved.
//

import UIKit

fileprivate var spinnerView: UIView?

extension UIViewController {
    
    func showSpinner() {
        spinnerView = UIView(frame: self.view.bounds)
        spinnerView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        if let spinnerView = spinnerView {
            spinnerView.addSubview(activityIndicator)
            self.view.addSubview(spinnerView)
        }
    }
    
    func removeSpinner() {
        if let spinnerView = spinnerView {
            spinnerView.removeFromSuperview()
        }
    }
}
