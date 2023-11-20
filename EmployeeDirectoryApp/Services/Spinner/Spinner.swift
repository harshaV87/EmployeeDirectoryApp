//
//  Spinner.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/20/23.
//

import Foundation
import UIKit

extension UIView {

    // SimpleSpinner
    func startAnimating(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 131132
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        backgroundView.addSubview(activityIndicator)
        self.addSubview(backgroundView)
    }

    func stopAnimating() {
        if let background = viewWithTag(131132) {
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
