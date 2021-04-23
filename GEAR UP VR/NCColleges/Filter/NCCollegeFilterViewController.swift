//
//  NCCollegeFilterViewController.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 06/01/2020.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import UIKit

enum CellType: Int, CaseIterable {
    case stateSelectionTableViewCell
    case rangeSliderTableViewCell
    case majorSelectionTableViewCell
    case studentsBodySizeTableViewCell

    var identifier: String {
        switch self {
        case .stateSelectionTableViewCell:
            return "StateSelectionTableViewCell"
        case .rangeSliderTableViewCell:
            return "RangeSliderTableViewCell"
        case .majorSelectionTableViewCell:
            return "MajorSelectionTableViewCell"
        case .studentsBodySizeTableViewCell:
            return "StudentsBodySizeTableViewCell"
        }
    }
}

enum FilterCells: Int, CaseIterable {
    case stateFilter, satScore, actScore, majors, studentBodySize, costPerYer

    var cellType: CellType {
        switch self {
        case .stateFilter:
            return .stateSelectionTableViewCell
        case .satScore:
            return .rangeSliderTableViewCell
        case .actScore:
            return .rangeSliderTableViewCell
        case .majors:
            return .majorSelectionTableViewCell
        case .studentBodySize:
            return .studentsBodySizeTableViewCell
        case .costPerYer:
            return .rangeSliderTableViewCell
        }
    }
}

class NCCollegeFilterViewController: UIViewController {
    @IBOutlet var tableview: UITableView?

    var stateType = NCCollegeService.shared.stateType
    var satScore = NCCollegeService.shared.satScore
    var actScore = NCCollegeService.shared.actScore
    var majors = NCCollegeService.shared.majors
    var studentCapacity = NCCollegeService.shared.studentCapacity
    var costPerYear = NCCollegeService.shared.costPerYear

    /// Closure  method from StudentsBodySizeTableViewCell to set minimum & maximum student capactiy
    func selectSize(capacity: MinMax?) {
        studentCapacity = capacity
    }

    func clearSelectSize() {
        studentCapacity = nil
    }

    /// Closure method from MajorSelectionTableViewCell to set selected majors
    /// - Parameter majors: array of majors
    func selectMajors(majors: [Major]) {
        self.majors = majors
        tableview?.reloadData()
    }

    ///  Closure method from RangeSliderTableViewCell to set title, minimum and maximum score
    /// - Parameter title: title
    /// - Parameter minimumScore: minimum parameter
    /// - Parameter maximumScore: maximum parameter
    func selectRange(title: String, minimumScore: CGFloat, maximumScore: CGFloat) {
        let range = MinMax(min: Float(minimumScore), max: Float(maximumScore))

        switch title {
        case satScoreTitle:
            satScore = range
        case actScoreTitle:
            actScore = range
        case costPerYearTitle:
            costPerYear = range
        default:
            break
        }
    }

    ///  Closure method from StateSelectionTableViewCell to set state
    /// - Parameter state: state parameter (In-state/Out-of-state)
    func selectState(state: String) {
        stateType = state
    }

    func applyFilters() {
        NCCollegeService.shared.stateType = stateType
        NCCollegeService.shared.satScore = satScore
        NCCollegeService.shared.actScore = actScore
        NCCollegeService.shared.majors = majors
        NCCollegeService.shared.studentCapacity = studentCapacity
        NCCollegeService.shared.costPerYear = costPerYear

        closeFilterView()
    }

    /// Closure method to reset filters
    func resetFilters() {
        stateType = FilterConstants.stateTypeIn
        satScore = MinMax(min: FilterConstants.satScoreMinimum, max: FilterConstants.satScoreMaximum)
        actScore = MinMax(min: FilterConstants.actScoreMinimum, max: FilterConstants.actScoreMaximum)
        costPerYear = MinMax(min: FilterConstants.costPerYearMinimum, max: FilterConstants.costPerYearMaximum)
        clearSelectSize()
        majors = nil
        tableview?.reloadData()

        applyFilters()
    }

    /// Method to close filter view
    @objc func closeFilterView() {
        tabBarController?.tabBar.isHidden = false
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        registerTableViewCells()
    }

    /// Method to register all tableview cells
    func registerTableViewCells() {
        for item in CellType.allCases {
            let cell = UINib(nibName: item.identifier, bundle: nil)
            tableview?.register(cell, forCellReuseIdentifier: item.identifier)
        }
    }

    ///  This method is to setup the navigation bar with associate buttons
    func setupNavigationBar() {
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(title: filterBy,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: nil)

        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage.filterCloseImage,
                                                                  style: UIBarButtonItem.Style.plain,
                                                                  target: self,
                                                                  action: #selector(closeFilterView))

        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

// MARK: - Tableview Datasource methods

extension NCCollegeFilterViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return FilterCells.allCases.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let filterCell = FilterCells(rawValue: indexPath.row) {
            let cell = tableview?.dequeueReusableCell(withIdentifier: filterCell.cellType.identifier,
                                                      for: indexPath)
            cell?.selectionStyle = .none

            switch filterCell {
            case .stateFilter:
                if let castedCell = cell as? StateSelectionTableViewCell {
                    castedCell.loadData(selectedValue: stateType)
                    castedCell.selectState = selectState
                }

            case .satScore:
                if let castedCell = cell as? RangeSliderTableViewCell {
                    castedCell.loadData(title: satScoreTitle,
                                        limit: MinMax(min: FilterConstants.satScoreMinimum, max: FilterConstants.satScoreMaximum),
                                        selected: satScore,
                                        currency: false)
                    castedCell.selectRange = selectRange
                }

            case .actScore:
                if let castedCell = cell as? RangeSliderTableViewCell {
                    castedCell.loadData(title: actScoreTitle,
                                        limit: MinMax(min: FilterConstants.actScoreMinimum, max: FilterConstants.actScoreMaximum),
                                        selected: actScore,
                                        currency: false)
                    castedCell.selectRange = selectRange
                }

            case .majors:
                if let castedCell = cell as? MajorSelectionTableViewCell {
                    if let majorsCount = majors?.count,
                        majorsCount > 0 {
                        castedCell.majorsCount.text = "\(majorsCount) selected"
                    } else {
                        castedCell.majorsCount.text = ""
                    }
                }

            case .studentBodySize:
                if let castedCell = cell as? StudentsBodySizeTableViewCell {
                    let sizeData1: [String: Any] = ["title": "Below 5,000",
                                                    "range": MinMax(min: 5000, max: -1, operation: Operation.lt)]
                    let sizeData2: [String: Any] = ["title": "5,000 - 10,000",
                                                    "range": MinMax(min: 5000, max: 10000, operation: Operation.bt)]
                    let sizeData3: [String: Any] = ["title": "10,001 - 15,000",
                                                    "range": MinMax(min: 10001, max: 15000, operation: Operation.bt)]
                    let sizeData4: [String: Any] = ["title": "Above 15,000",
                                                    "range": MinMax(min: 15001, max: -1, operation: Operation.gt)]
                    castedCell.loadData(items: [sizeData1, sizeData2, sizeData3, sizeData4],
                                        selectedRange: studentCapacity)

                    castedCell.selectSize = selectSize
                    castedCell.clearSelectSize = clearSelectSize
                }

            case .costPerYer:
                if let castedCell = cell as? RangeSliderTableViewCell {
                    castedCell.loadData(title: costPerYearTitle,
                                        limit: MinMax(min: FilterConstants.costPerYearMinimum, max: FilterConstants.costPerYearMaximum),
                                        selected: costPerYear,
                                        currency: true)
                    castedCell.selectRange = selectRange
                }
            }

            return cell!
        }

        return UITableViewCell()
    }
}

// MARK: - Tableview Delegate methods

extension NCCollegeFilterViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if FilterCells(rawValue: indexPath.row) == FilterCells.majors {
            let majorsViewController = NCCollegeMajorsViewController()
            if let thisMajors = majors {
                majorsViewController.selectedMajors = thisMajors
            }

            majorsViewController.selectTheseMajors = selectMajors

            navigationController?.pushViewController(majorsViewController, animated: true)
        }
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            return UITableView.automaticDimension
        } else {
            return 85.0
        }
    }

    func tableView(_: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 4 {
            return UITableView.automaticDimension
        } else {
            return 85.0
        }
    }

    func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        return 70.0
    }

    func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
        if let footerView = (FilterButtonTableViewFooter().loadNib() as? FilterButtonTableViewFooter) {
            footerView.resetFilter = resetFilters
            footerView.applyFilters = applyFilters
            return footerView
        }

        return nil
    }
}
