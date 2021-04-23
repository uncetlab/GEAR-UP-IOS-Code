//
//  ViewController_Extension.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 15/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import NVActivityIndicatorView
import UIKit

extension UIViewController: NVActivityIndicatorViewable {
    /// This method is to show alert message to the user
    /// - Parameter message: The message to show in the alert box
    /// - Parameter defaultButtonTitle:default button title
    func showStandardAlert(message: String!, defaultButtonTitle: String? = "Ok") {
        let bundleName = Bundle.main.displayName

        let alert = UIAlertController(title: bundleName, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: defaultButtonTitle, style: UIAlertAction.Style.default, handler: { _ in

        }))

        present(alert, animated: true, completion: nil)
    }

    /// This method is to show activity indicator symbol while the application is performing a task
    func showActivityIndicator() {
        let indicatorColor = UIColor.activityIndicator

        startAnimating(CGSize(width: 40, height: 40),
                       message: nil,
                       messageFont: nil,
                       type: .lineScalePulseOut,
                       color: indicatorColor,
                       padding: nil,
                       displayTimeThreshold: nil,
                       minimumDisplayTime: nil,
                       backgroundColor: nil,
                       textColor: nil,
                       fadeInAnimation: nil)
    }
}
