//
//  NCCollegesViewController.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 24/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import MapKit
import QuartzCore
import UIKit

class NCCollegesViewController: UIViewController {
    @IBOutlet var viewType: SegmentedControl!
    @IBOutlet var containerView: UIView!

    var ncCollegeService: NCCollegeService = NCCollegeService.shared
    var listViewController: NCCollegesListViewController = NCCollegesListViewController()
    var mapViewController: NCCollegesMapViewController = NCCollegesMapViewController()
    var searchField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewType()

        applyTheme()
        setupNavigationBar()
        edgesForExtendedLayout = []
        containerView.setNeedsLayout()
        setupSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        var rightBarButtonItem: UIBarButtonItem
        if ncCollegeService.isFilterApplied {
            rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_filter_fill"),
                                                 style: UIBarButtonItem.Style.plain,
                                                 target: self,
                                                 action: #selector(openFilterView))

        } else {
            rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_filter_outline"),
                                                 style: UIBarButtonItem.Style.plain,
                                                 target: self,
                                                 action: #selector(openFilterView))
        }

        navigationItem.rightBarButtonItem = rightBarButtonItem

        changeViewType()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchField?.resignFirstResponder()
        clearSearch()
    }

    ///  This method is to clear search text
    func clearSearch() {
        NCCollegeService.shared.searchKey = nil
        navigationItem.titleView = nil
        searchField?.text = nil
    }

    func applyTheme() {
        view.backgroundColor = UIColor.visitNCListCellBGColor

        viewType.segmentColor = UIColor.visitNCSegmentBGColor
        viewType.segmentTextColor = UIColor.visitNCSegmentNormalTextColor

        viewType.selectedSegmentColor = UIColor.visitNCSelectedSegmentTintColor
        viewType.selectedSegmentTextColor = UIColor.visitNCSegmentSelectedTextColor
    }

    ///  This method is to setup the navigation bar with associate buttons
    func setupNavigationBar() {
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_search"),
                                                                 style: UIBarButtonItem.Style.plain,
                                                                 target: self,
                                                                 action: #selector(toggleSearchField))
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_filter_outline"),
                                                                  style: UIBarButtonItem.Style.plain,
                                                                  target: self,
                                                                  action: #selector(openFilterView))

        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    ///  This method is to setup the view type button
    func setupViewType() {
        viewType.items = ["List View", "Map View"]
        viewType.selectedSegmentIndex = 0
        viewType.segmentControlDidChangeValue = { _ in
            self.changeViewType()
        }
    }

    ///  This method is to setup the navigation bar with associate buttons
    func setupSearchBar() {
        searchField = UNCTextField(frame: CGRect(x: 0.0, y: 0.0, width: 320, height: 40.0), style: .standard)
        searchField?.delegate = self

        if let textField = searchField {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
            textField.leftView = paddingView
            textField.leftViewMode = .always
        }
    }

    /// method to change view type list view / map view
    func changeViewType() {
        containerView.subviews.forEach { $0.removeFromSuperview() }
        if viewType.selectedSegmentIndex == 0 {
            listViewController.view.frame = containerView.bounds
            containerView.addSubview(listViewController.view)
            addChild(listViewController)
            listViewController.didMove(toParent: self)
        } else {
            mapViewController.view.frame = containerView.bounds
            containerView.addSubview(mapViewController.view)
            addChild(mapViewController)
            mapViewController.didMove(toParent: self)
        }
    }

    /// Method to show search field
    @objc func toggleSearchField() {
        if navigationItem.titleView == searchField {
            navigationItem.titleView = nil
            navigationItem.title = title
            ncCollegeService.searchKey = nil
            searchField?.text = nil
            listViewController.showActivityIndicator()
            listViewController.loadData(loadMore: true)
        } else {
            navigationItem.titleView = searchField
            searchField?.becomeFirstResponder()
        }
    }

    /// Method to open filter screen
    @objc func openFilterView() {
        let screen = NCCollegeFilterViewController()
        let navController = UINavigationController(rootViewController: screen)
        navController.modalPresentationStyle = .fullScreen
        present(navController,
                animated: true,
                completion: nil)
    }
}

extension NCCollegesViewController: UITextFieldDelegate {
    /// - Parameter textField: search field
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField == searchField {
            ncCollegeService.searchKey = nil
        }

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchField {
            ncCollegeService.searchKey = textField.text
            children.forEach { if let listViewController = $0 as? NCCollegesListViewController {
                listViewController.showActivityIndicator()
                listViewController.loadData(loadMore: false)
				} }
        }
        textField.resignFirstResponder()
        return true
    }
}
