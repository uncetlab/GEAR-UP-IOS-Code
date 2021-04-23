//
//  RootViewController.swift
//  GEAR UP VR
//
//  Created by Shineeth Hamza on 17/10/19.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import KeychainSwift
import UIKit

class ComingSoonViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let config = Configuration()

        if config.environment != Environment.production, config.environment != Environment.uat {
            let button: UIButton = UIButton()
            button.backgroundColor = UIColor.red
            button.setTitle("Delete Analytics Submited", for: .normal)
            button.addTarget(self, action: #selector(deleteAnalyticsSubmitedValued), for: .touchUpInside)
            view.addSubview(button)

            button.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }

    @objc func deleteAnalyticsSubmitedValued() {
        KeychainSwift().delete(Key.isAnalyticsSubmited.rawValue)

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.prepareRootViewController(animated: true)
        }
    }
}
