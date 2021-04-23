//
//  HomeLaunchViewController.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 22/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import NVActivityIndicatorView
import UIKit

class HomeLaunchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        showActivityIndicator()

        let menuService = MenuService()
        menuService.fetchMenuItems { menu, _ in

            self.stopAnimating()

            if let menuItems = menu {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.prepareRootViewController(animated: true, window: nil, menu: menuItems)
                }
            }

        }
    }
}
