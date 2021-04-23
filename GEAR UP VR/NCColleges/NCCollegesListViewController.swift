//
//  NCCollegesListViewController.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 07/12/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import NVActivityIndicatorView
import UIKit
class NCCollegesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    public var collegeList: [College]?
    public var tableActivityIndicator: NVActivityIndicatorView?
    var isBusy = false
    let tableview: UITableView
    let cellReuseIdentifier = "NCCollegesListTableViewCell"
    let noItemIdentifier = "NoItemTableViewCell"
    var serviceCompletionHandler: (([College]?, Bool, Error?) -> Void)?

    /// This method is to initialize list view controller with list of colleges
    /// - Parameter frame: Map screen frame
    init() {
        tableview = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.keyboardDismissMode = .onDrag

        super.init(nibName: nil, bundle: nil)

        view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            tableview.topAnchor
                .constraint(equalTo: view.topAnchor),
            tableview.bottomAnchor
                .constraint(equalTo: view.bottomAnchor),
            tableview.trailingAnchor
                .constraint(equalTo: view.trailingAnchor)
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let cell = UINib(nibName: cellReuseIdentifier, bundle: nil)
        tableview.register(cell, forCellReuseIdentifier: cellReuseIdentifier)

        let noItemcell = UINib(nibName: noItemIdentifier, bundle: nil)
        tableview.register(noItemcell, forCellReuseIdentifier: noItemIdentifier)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshListItems(_:)), for: .valueChanged)
        tableview.refreshControl = refreshControl

        applyTheme()
        tableview.delegate = self
        tableview.dataSource = self

        tableview.rowHeight = 105
        tableview.reloadData()

        setupTableActivityIndicator()

        serviceCompletionHandler = { colleges, loadMore, error in
            if error != nil {
                self.showStandardAlert(message: error?.localizedDescription)
            } else {
                if !loadMore || self.collegeList == nil {
                    self.collegeList = colleges
                } else if colleges != nil {
                    self.collegeList! += colleges!
                }
            }
            self.isBusy = false
            self.tableview.reloadData()
            self.tableActivityIndicator?.stopAnimating()
            self.tableview.refreshControl?.endRefreshing()
            self.stopAnimating()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        showActivityIndicator()
        loadData(loadMore: false)
    }

    func applyTheme() {
        tableview.backgroundColor = UIColor.clear
        tableview.separatorColor = UIColor.clear
        view.backgroundColor = UIColor.visitNCListCellBGColor
    }

    /// This method is to setup  activity indicator for the table footer section
    func setupTableActivityIndicator() {
        let indicatorColor = UIColor.activityIndicator

        let indicatorFrame = CGRect(x: (tableview.frame.width / 2) - 10,
                                    y: 10,
                                    width: 40,
                                    height: 40)

        tableActivityIndicator = NVActivityIndicatorView(frame: indicatorFrame,
                                                         type: .lineScalePulseOut,
                                                         color: indicatorColor,
                                                         padding: 0)
    }

    /// This method is to refresh list of items in the table view,, once pull to refresh is called
    /// - Parameter sender: sender
    @objc func refreshListItems(_: Any) {
        loadData(loadMore: false)
    }

    func loadData(loadMore: Bool) {
        if isBusy {
            return
        }

        isBusy = true

        NCCollegeService.shared.fetchListOfColleges(loadMore: loadMore) { colleges, error in
            self.serviceCompletionHandler?(colleges, loadMore, error)
        }
    }

    // MARK: Tableview Datasource methods

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if let list = collegeList, !list.isEmpty {
            return list.count
        }
        return isBusy ? 0 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let list = collegeList, !list.isEmpty {
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier,
                                                        for: indexPath) as? NCCollegesListTableViewCell {
                cell.loadData(item: collegeList?[indexPath.row])
                cell.selectionStyle = .none
                return cell
            }

        } else if let cell = tableView.dequeueReusableCell(withIdentifier: noItemIdentifier,
                                                           for: indexPath) as? NoItemTableViewCell {
            return cell
        }

        return UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
    }

    func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
        let footerView: UIView = UIView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: tableview.frame.width,
                                                      height: 60))

        if let activity = tableActivityIndicator {
            footerView.addSubview(activity)
        }
        return footerView
    }

    // MARK: Tableview Delegate methods

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let uid = collegeList?[indexPath.row].uid {
            let detailViewcontroller = CollegeDetailViewController()
            detailViewcontroller.universityID = uid
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
