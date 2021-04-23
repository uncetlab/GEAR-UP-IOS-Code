//
//  UserSelectionViewController.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 01/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import UIKit

class UserSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var userTypes: [UserTypeElement]?

    @IBOutlet var userTypeSelectionBG: UIImageView!
    @IBOutlet var userSelectionTitle: UILabel!
    @IBOutlet var tableView: UITableView!

    let cellReuseIdentifier = "UserSelectionTableViewCell"
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    // MARK: Tableview Datasource methods

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return userTypes?.count ?? 0
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: UserSelectionTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? UserSelectionTableViewCell {
            if let currentUserType = userTypes?[indexPath.row] {
                cell.loadData(type: currentUserType)
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }

    // MARK: Tableview Delegate methods

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentUserType = userTypes?[indexPath.row] {
            if currentUserType.title.caseInsensitiveCompare("other") == .orderedSame {
                submitAnalytics(userType: currentUserType)
            } else {
                let highSchoolSearchViewController = HighSchoolSearchViewController()
                highSchoolSearchViewController.userType = currentUserType
                navigationController?.pushViewController(highSchoolSearchViewController, animated: true)
            }

        } else {
            showStandardAlert(message: "Unable to select user type")
        }
    }

    /// All the user types will be loaded from the server in this method.
    override func viewDidLoad() {
        super.viewDidLoad()

        applyTheme()
        showActivityIndicator()

        let cell = UINib(nibName: cellReuseIdentifier, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        let analyticService = AnalyticsService()

        analyticService.fetchUserTypes { types, _ in

            self.userTypes = types

            self.stopAnimating()

            if self.userTypes != nil {
                self.tableView.reloadData()
            }
        }

        // Do any additional setup after loading the view.
    }

    /// This method is to setup theme
    func applyTheme() {
        userTypeSelectionBG.image = UIImage.userTypeSelectionBG
        userSelectionTitle.textColor = UIColor.userSelectionTitleColor
        userSelectionTitle.font = UIFont.userSelectionTitleFont
    }

    /// This method is to submit analytics to the server and navigate to home screen
    /// - Parameter userType: UserType Object
    func submitAnalytics(userType: UserTypeElement) {
        showActivityIndicator()
        let analyticService = AnalyticsService()
        analyticService.submitUserAnalytics(deviceId: UIDevice.current.identifierForVendor?.uuidString ?? "",
                                            userType: userType,
                                            school: nil,
                                            customSchool: "") { _, error in
            if error != nil {
                self.stopAnimating()
                self.showStandardAlert(message: error?.localizedDescription)
            } else {
                let menuService = MenuService()
                menuService.fetchMenuItems { menu, _ in

                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                        self.stopAnimating()
                        appDelegate.prepareRootViewController(animated: true,
                                                              window: nil,
                                                              menu: menu)
                    }
                }
            }
        }
    }
}
