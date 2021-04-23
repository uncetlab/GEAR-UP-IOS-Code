//
//  CareersViewController.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 28/04/2020.
//  Copyright © 2020 Marlabs Inc. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CareersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    let cellRowIdentifier = "CareerTableViewCell"
    let noItemIdentifier = "NoItemTableViewCell"
    var isBusy = false
    var serviceCompletionHandler: (([Career]?, Bool, Error?) -> Void)?
    public var tableActivityIndicator: NVActivityIndicatorView?
    public var careerList: [Career]?
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellRow = UINib(nibName: cellRowIdentifier, bundle: nil)
        self.tableView?.register(cellRow, forCellReuseIdentifier: cellRowIdentifier)

        let noItemcell = UINib(nibName: noItemIdentifier, bundle: nil)
        self.tableView.register(noItemcell, forCellReuseIdentifier: noItemIdentifier)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshListItems(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl

        applyTheme()
        setupTableActivityIndicator()

        serviceCompletionHandler = { careers, loadMore, error in
            if error != nil {
                self.showStandardAlert(message: error?.localizedDescription)
            } else {
                if !loadMore || self.careerList == nil {
                    self.careerList = careers
                } else if careers != nil {
                    self.careerList! += careers!
                }
            }

            self.isBusy = false
            self.tableView.reloadData()
            self.tableActivityIndicator?.stopAnimating()
            self.tableView.refreshControl?.endRefreshing()
            self.stopAnimating()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        showActivityIndicator()
        loadData(loadMore: false)
    }

    /// This method is to refresh data from the server
    @objc func refreshListItems(_: Any) {
        loadData(loadMore: false)
    }

    /// This method is to load data from the server
    func loadData(loadMore: Bool) {
        if isBusy {
            return
        }

        isBusy = true

        CareerService.shared.fetchListOfCareers(loadMore: loadMore) { careers, error in
            self.serviceCompletionHandler?(careers, loadMore, error)
        }
    }

    /// This method is to setup  activity indicator for the table footer section
    func setupTableActivityIndicator() {
        let indicatorColor = UIColor.activityIndicator

        let indicatorFrame = CGRect(x: (tableView.frame.width / 2) - 10,
                                    y: 10,
                                    width: 40,
                                    height: 40)

        tableActivityIndicator = NVActivityIndicatorView(frame: indicatorFrame,
                                                         type: .lineScalePulseOut,
                                                         color: indicatorColor,
                                                         padding: 0)
    }

    /// Apply application enviornment theme
    func applyTheme() {
        self.view.backgroundColor = UIColor.careersBgColor
    }

    // MARK: Tableview Datasource methods

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if let list = self.careerList, !list.isEmpty {
            return list.count
        }
        return isBusy ? 0 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellRow = tableView.dequeueReusableCell(withIdentifier: cellRowIdentifier, for: indexPath) as? CareerTableViewCell ?? CareerTableViewCell()

        if let list = self.careerList, !list.isEmpty, let career = self.careerList?[indexPath.row] {
            cellRow.loadData(item: career)
            cellRow.selectionStyle = .none
            cellRow.loadData(item: career)
            return cellRow

        } else if let cell = tableView.dequeueReusableCell(withIdentifier: noItemIdentifier,
                                                           for: indexPath) as? NoItemTableViewCell {
            return cell
        }

        return UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")

    }

    // MARK: Tableview Delegate methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if let careerID = self.careerList?[indexPath.row].uid {
            let detailViewcontroller = CareerDetailViewController()
            detailViewcontroller.careerID = careerID
            navigationController?.pushViewController(detailViewcontroller, animated: true)
        }

    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate _: Bool) {
        // Bottom Refresh
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if (scrollView.contentOffset.y + scrollView.frame.size.height + 300) >= scrollView.contentSize.height,
            actualPosition.y <= 0,
            !isBusy {
            tableActivityIndicator?.startAnimating()
            loadData(loadMore: true)
        }
    }

}
