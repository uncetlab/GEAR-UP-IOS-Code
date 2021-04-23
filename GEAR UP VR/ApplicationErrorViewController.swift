//
//  ApplicationErrorViewController.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 09/03/2020.
//  Copyright © 2020 Marlabs Inc. All rights reserved.
//

import UIKit

class ApplicationErrorViewController: UIViewController {
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var mainTitleText: UILabel!
    @IBOutlet var tryAgain: UIButton!
    @IBOutlet var userInfo: UILabel!
    var contactInformation: String = ""
    init(errorStatusCode: APIStatusCode) {
        let config = Configuration()

        switch errorStatusCode {
        case .invalidUniversity:
            contactInformation = ErrorMessages.InactiveUniversityInfo + config.contactEmail

        case .invalidUser:
             contactInformation = ErrorMessages.InactiveUserInfo + config.contactEmail

        case .genericError:
             contactInformation = ErrorMessages.genericErrorInfo + config.contactEmail

        }

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tryAgain.layer.cornerRadius = 10.0
        tryAgain.layer.borderColor = UIColor.clear.cgColor
        tryAgain.layer.borderWidth = 1.0

        userInfo.text = contactInformation

        view.backgroundColor = UIColor.applicationErrorViewControllerBGColor

        mainImage.image = UIImage.applicationErrorViewControllerMainImage

        mainTitleText.font = UIFont.applicationErrorViewControllerMainTitleFont
        mainTitleText.textColor = UIColor.applicationErrorViewControllerMainTitleColor

        userInfo.font = UIFont.applicationErrorViewControllerUserInfoFont
        userInfo.textColor = UIColor.applicationErrorViewControllerUserInfoColor

        tryAgain.titleLabel?.font = UIFont.applicationErrorViewControllerTryButtonFont
        tryAgain.backgroundColor = UIColor.applicationErrorViewControllerTryButtonBgColor
        tryAgain.titleLabel?.textColor = UIColor.applicationErrorViewControllerTryButtonTextColor

        // Do any additional setup after loading the view.
    }

    @IBAction func reloadApplication(_: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.prepareRootViewController(animated: true)
        }
    }
}
