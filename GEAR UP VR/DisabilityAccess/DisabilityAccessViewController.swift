//
//  DisabilityAccessViewController.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 24/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import UIKit

class DisabilityAccessViewController: NCCollegesListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.disabilityAccessBgColor
        navigationItem.title = title
        setupSearchBar()
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clearSearch()
    }

    ///  This method is to clear search text
    func clearSearch() {
        NCCollegeService.shared.searchKey = nil
        navigationItem.searchController?.searchBar.text = nil
        navigationItem.searchController?.isActive = false
    }

    ///  This method is to setup the navigation bar with associate buttons
    func setupSearchBar() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.searchController?.delegate = self
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.tintColor = UIColor.searchTextFieldColor

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.searchTextFieldColor]
    }

    override func loadData(loadMore: Bool) {
        if isBusy {
            return
        }

        isBusy = true

        NCCollegeService.shared.fetchListOfColleges(loadMore: loadMore, disabilityaccess: true) { colleges, error in
            self.serviceCompletionHandler?(colleges, loadMore, error)
        }
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let disabilityAccessURL = collegeList?[indexPath.row].disabilityAccessURL {
            if let url = URL(string: disabilityAccessURL), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showStandardAlert(message: ErrorMessages.youtubeNotConfigured)
            }
        }
    }
}

extension DisabilityAccessViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text?.lowercased() {
            NCCollegeService.shared.searchKey = text
            showActivityIndicator()
            loadData(loadMore: false)
        } else {}
    }

    func didDismissSearchController(_: UISearchController) {
        NCCollegeService.shared.searchKey = nil
        showActivityIndicator()
        loadData(loadMore: false)
    }
}
