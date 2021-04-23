//
//  NCCollegeMajorsViewController.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 08/01/2020.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import UIKit

class NCCollegeMajorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var selectButton: UIButton!
    @IBOutlet var selectedMajorsCount: UILabel!
    @IBOutlet var tableview: UITableView?

    var majorsTextField: UITextField?
    let cellRowIdentifier = "NCCollegeMajorsTableViewCell"
    var ncCollegeService: NCCollegeService?
    var majors: [Major]?
    var tableItems: [Major]?
    var selectedMajors: [Major]?
    public var selectTheseMajors: (([Major]) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

        view.backgroundColor = UIColor.majorSelectionBgColor

        selectButton.backgroundColor = UIColor.majorSelectionApplyButtonBgColor
        selectButton.setTitleColor(.majorSelectionApplyButtonTintColor, for: .normal)

        selectedMajorsCount.textColor = UIColor.selectedMajorsCountColor

        resetButton.backgroundColor = UIColor.majorSelectionResetButtonBgColor
        resetButton.setTitleColor(.majorSelectionResetButtonTextColor, for: .normal)

        resetButton?.titleLabel?.font = UIFont.majorSelectionResetButtonFont ?? UIFont()
        selectButton?.titleLabel?.font = UIFont.majorSelectionApplyButtonFont ?? UIFont()
        majorsTextField?.font = UIFont.majorSearchFieldFont
        ncCollegeService = NCCollegeService.shared

        let cellRow = UINib(nibName: cellRowIdentifier, bundle: nil)

        tableview?.register(cellRow, forCellReuseIdentifier: cellRowIdentifier)

        if selectedMajors == nil {
            selectedMajors = []
        }

        fetchMajorsList()
    }

    /// Method to set the selected majors and return them to parent view controller
    /// - Parameter sender: sender
    @IBAction func selectMajors(_: Any) {
        if let receivedMajors = selectTheseMajors {
            receivedMajors(selectedMajors ?? [])
        }
        navigationController?.popViewController(animated: true)
    }

    /// Reset selected majors
    /// - Parameter sender: sender
    @IBAction func resetMajors(_: Any) {
        selectedMajors?.removeAll()
        if let receivedMajors = selectTheseMajors {
            receivedMajors(selectedMajors ?? [])
        }
        navigationController?.popViewController(animated: true)
    }

    /// This method is to fetch all majors
    func fetchMajorsList() {
        showActivityIndicator()
        ncCollegeService?.fetchListOfMajors(completionHandler: { items, error in
            self.stopAnimating()
            if error != nil {
                self.majors = []
                self.showStandardAlert(message: "Unable to load data. Please try after some time.")
            } else {
                if let majorItems = items {
                    self.majors = majorItems
                } else {
                    self.majors = []
                }
            }
            self.tableItems = self.majors
            self.tableview?.reloadData()
        })
    }

    ///  This method is to setup the navigation bar with associate buttons
    func setupNavigationBar() {
        let backBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_arrow_back_blue"), style: .plain, target: self, action: #selector(backToFilterView))

        navigationItem.leftBarButtonItem = backBarButtonItem

        majorsTextField = UNCTextField(frame: CGRect(x: 0.0, y: 0.0, width: 320, height: 40.0), style: .standard)

        navigationItem.titleView = majorsTextField
        majorsTextField?.delegate = self
        majorsTextField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }

    /// Close the screen and move back to filter screen
    @objc func backToFilterView() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: Tableview Datasource methods

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return tableItems?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellRow = tableView.dequeueReusableCell(withIdentifier: cellRowIdentifier, for: indexPath) as? NCCollegeMajorsTableViewCell ?? NCCollegeMajorsTableViewCell()

        if let major = tableItems?[indexPath.row] {
            cellRow.loadData(major: major)
        }

        if (selectedMajors?.firstIndex(where: { $0.title == self.tableItems?[indexPath.row].title })) != nil {
            cellRow.checkMark.image = UIImage.majorSelectedRadio

        } else {
            cellRow.checkMark.image = UIImage.majorSelectionRadio
        }

        let selectedMajorsCount: Int = selectedMajors?.count ?? 0
        if selectedMajorsCount > 0 {
            self.selectedMajorsCount.text = String(selectedMajorsCount) + " Selected"
        } else {
            self.selectedMajorsCount.text = ""
        }

        cellRow.selectionStyle = .none
        return cellRow
    }

    // MARK: Tableview Delegate methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellRow = tableView.cellForRow(at: indexPath) as? NCCollegeMajorsTableViewCell

        if let itemIndex = selectedMajors?.firstIndex(where: { $0.title == self.tableItems?[indexPath.row].title }) {
            cellRow?.checkMark.image = UIImage.majorSelectionRadio
            selectedMajors?.remove(at: itemIndex)
        } else {
            if let major = tableItems?[indexPath.row] {
                cellRow?.checkMark.image = UIImage.majorSelectedRadio
                selectedMajors?.append(major)
            }
        }

        let selectedMajorsCount: Int = selectedMajors?.count ?? 0
        if selectedMajorsCount > 0 {
            self.selectedMajorsCount.text = String(selectedMajorsCount) + " Selected"
        } else {
            self.selectedMajorsCount.text = ""
        }
    }

    /// Identifies change in search field
    /// - Parameter textField: major search field
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 0 {
            tableItems = majors?.filter { ($0.title?.contains(textField.text ?? "") ?? false) }

            tableview?.reloadData()

        } else {
            tableItems = majors
        }

        tableview?.reloadData()
    }

    /// Method to clear search field text
    /// - Parameter textField: search field
    func textFieldShouldClear(_: UITextField) -> Bool {
        tableItems = majors
        tableview?.reloadData()

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
