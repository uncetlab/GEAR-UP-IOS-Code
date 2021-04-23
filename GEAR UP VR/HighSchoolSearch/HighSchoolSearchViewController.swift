//
//  HighSchoolSearchViewController.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 04/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import NVActivityIndicatorView
import UIKit

class HighSchoolSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet var searchArrow: UIButton!
    @IBOutlet var separatorLine: UIView!
    @IBOutlet var highSchoolSelectionBG: UIImageView!
    @IBOutlet var searchField: UITextField!
    @IBOutlet var searchFieldContainer: UIView!
    @IBOutlet var tableView: UITableView!
    var schools: [School]?
    var userType: UserTypeElement?
    var selectedSchool: School?
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    @IBOutlet var highschoolSelectionTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        applyTheme()
        setupSearchField()
        setupTableView()

        searchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

        let cell = UINib(nibName: cellReuseIdentifier, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: cellReuseIdentifier)
    }

    func applyTheme() {
        highSchoolSelectionBG.image = UIImage.highSchoolSelectionBG
        searchFieldContainer.backgroundColor = UIColor.highSchoolSelectionCellBGColor
        highschoolSelectionTitle.textColor = UIColor.highSchoolSelectionTitleColor
        highschoolSelectionTitle.font = UIFont.highSchoolSelectionTitleFont
        separatorLine.backgroundColor = UIColor.searchBarSeperatorLine
        searchField.textColor = UIColor.highSchoolSearchFieldTextColor
        searchArrow.setImage(UIImage.searchArrow, for: .normal)
    }

    func setupSearchField() {
        searchFieldContainer.layer.cornerRadius = 5.0
        searchFieldContainer.layer.borderWidth = 1.0
        searchFieldContainer.layer.borderColor = UIColor.clear.cgColor
        searchFieldContainer.layer.masksToBounds = true
        searchField.clearButtonMode = UITextField.ViewMode.whileEditing
        searchField.delegate = self
    }

    func setupTableView() {
        tableView.layer.cornerRadius = 5.0
        tableView.layer.borderWidth = 1.0

        tableView.layer.borderColor = UIColor.clear.cgColor
        tableView.layer.masksToBounds = true
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

    let cellReuseIdentifier = "HighSchoolSearchTableViewCell"

    // MARK: Tableview Datasource methods

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return schools?.count ?? 0
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: HighSchoolSearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? HighSchoolSearchTableViewCell {
            if let currentSchool = schools?[indexPath.row] {
                cell.loadData(school: currentSchool)
            }
            cell.selectionStyle = .none

            return cell
        }

        return UITableViewCell()
    }

    // MARK: Tableview Delegate methods

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentSchool = schools?[indexPath.row] {
            selectedSchool = currentSchool
            searchField.text = selectedSchool?.name
        }
    }

    /// This method clears the tableview if the textfield data is about to be cleared
    /// - Parameter textField: Search field
    func textFieldShouldClear(_: UITextField) -> Bool {
        schools = nil
        tableView.reloadData()

        return true
    }

    /// This delegate method identifies if there a change in the school data provided by the user. If search data exceeds 3 characters, executes school fetch api
    /// - Parameter textField: Search field
    @objc func textFieldDidChange(_ textField: UITextField) {
        selectedSchool = nil
        if textField.text?.count ?? 0 > 3 {
            showActivityIndicator()
            let analyticService = AnalyticsService()
            analyticService.fetchHighSchools(query: textField.text) { schools, _, responseQuery in
                if responseQuery == self.searchField.text {
                    self.schools = schools
                    self.stopAnimating()
                    if self.schools != nil {
                        self.tableView.reloadData()
                    }
                }
            }
        } else {
            schools = nil
            tableView.reloadData()
            stopAnimating()
        }
    }

    /// This method is to navigate to the previous screen
    /// - Parameter sender: normal IbAction sender parameter
    @IBAction func back(_: Any) {
        navigationController?.popViewController(animated: true)
    }

    /// This IBAction is for submitting the data provided by the user
    /// - Parameter sender: normal IbAction sender parameter
    @IBAction func submitAnalytics(_ sender: UIButton) {
        if selectedSchool == nil && searchField.text?.count == 0 {
            showStandardAlert(message: "Please provide school details to continue.")
        } else if userType == nil || userType?.uid == nil {
            showStandardAlert(message: "Something went wrong. No user type data available. Please go back to previous screen and try again.")
        } else {
            sender.isEnabled = false
            showActivityIndicator()
            let analyticService = AnalyticsService()
            analyticService.submitUserAnalytics(deviceId: UIDevice.current.identifierForVendor?.uuidString ?? "",
                                                userType: userType!,
                                                school: selectedSchool,
                                                customSchool: searchField.text) { _, error in
                sender.isEnabled = true
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
}
