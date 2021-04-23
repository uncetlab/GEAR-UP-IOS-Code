//
//  HomeViewController.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 24/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import NVActivityIndicatorView
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var playButton: UIButton!
    @IBOutlet var headerView: UIView!
    @IBOutlet var videoThumbnailView: UIImageView!
    @IBOutlet var videoTitleView: UIView!
    @IBOutlet var videoTitle: UILabel!
    @IBOutlet var tableView: UITableView!
    var home: Home?
    let cellReuseIdentifier = "HomeTableViewCell"
    var homeService: HomeService = HomeService()
    var vrPlayer: VRPlayerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = []
        applyTheme()

        headerView.isHidden = true

        playButton.clipsToBounds = false
        playButton.layer.shadowColor = UIColor.darkGray.cgColor
        playButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        playButton.layer.shadowRadius = 5
        playButton.layer.shadowOpacity = 0.8

        let cell = UINib(nibName: cellReuseIdentifier, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.tableHeaderView = headerView
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        loadData()
    }

    /// This method is to setup theme
    func applyTheme() {
        tableView.backgroundColor = UIColor.homeViewBGColor
        videoTitle.textColor = UIColor.videoTitleColor
        videoTitleView.backgroundColor = UIColor.videoTitleViewBGColor
    }

    @objc func loadData() {
        if home == nil {
            showActivityIndicator()
        }

        homeService.fetchHomeScreenItems { item, _ in
            self.stopAnimating()
            if let refreshControl = self.tableView.refreshControl, refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
            if item != nil {
                self.home = item
                if let video = self.home?.video {
                    self.headerView.isHidden = false
                    self.playButton.isHidden = false
                    self.videoTitle.text = video.name
                    if let sourceURL = URL(string: video.url) {
                        self.vrPlayer = VRPlayerViewController(url: sourceURL)
                    }

                    if video.thumbnail != nil {
                        let imageService = ImageService()
                        imageService.fetchVideoThumbnailImage(video: video) { video, _ in

                            if let imageFilePath = video.imageLocalFilePath {
                                self.videoThumbnailView.image = UIImage(contentsOfFile: imageFilePath)
                            } else {
                                self.videoThumbnailView.image = UIImage.videoPlaceHolderImage
                            }
                        }
                    } else {
                        self.videoThumbnailView.image = UIImage.videoPlaceHolderImage
                    }
                }
                self.tableView.reloadData()
            } else {
                self.showStandardAlert(message: "Unable to load data. Please try after some time.")
            }
        }
    }

    @IBAction func playButtonDidPressed(_: UIButton) {

        let menuViewController = self.tabBarController as? MenuViewController
        menuViewController?.changeOrientation = true

        let value = UIInterfaceOrientation.landscapeLeft.rawValue
         UIDevice.current.setValue(value, forKey: "orientation")

        if let player = self.vrPlayer {
            self.navigationController?.pushViewController(player, animated: true)

        }

    }

    // MARK: Tableview Datasource methods

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if let activeTilesCount = home?.activeTiles.count {
            return activeTilesCount
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier,
                                                    for: indexPath) as? HomeTableViewCell {
            if let tile = home?.activeTiles[indexPath.row] {
                cell.loadData(tile: tile, homeService: homeService)
            } else {
                #if DEBUG
                    print("Unable to load data. Please try after some time.")
                #endif
            }

            cell.selectionStyle = .none

            return cell
        }

        return UITableViewCell()
    }

    // MARK: Tableview Delegate methods

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tile = home?.activeTiles[indexPath.row] {
            let screen = ContentDetailViewController(dashboardTile: tile)
            screen.content = tile
            navigationController?.pushViewController(screen, animated: true)
        }
    }
}
