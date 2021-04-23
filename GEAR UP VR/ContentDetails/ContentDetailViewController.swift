//
//  ContentDetailViewController.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 06/11/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import UIKit
import WebKit

class ContentDetailViewController: BaseWebViewViewController {
    @IBOutlet var webViewHeight: NSLayoutConstraint!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var playButton: UIButton!
    public var content: DashboardTile

    var vrPlayer: VRPlayerViewController?
    var page: Page?

    @IBOutlet var playerViewHeightConstraint: NSLayoutConstraint!

    init(dashboardTile: DashboardTile) {
        content = dashboardTile
        super.init(nibName: nil, bundle: nil)
    }

    init(menuElement: MenuElement) {
        content = DashboardTile(with: menuElement)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.uiDelegate = self
        webView.navigationDelegate = self
        edgesForExtendedLayout = []
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        showActivityIndicator()

        playButton.isHidden = true
        playButton.clipsToBounds = false
        playButton.layer.shadowColor = UIColor.darkGray.cgColor
        playButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        playButton.layer.shadowRadius = 5
        playButton.layer.shadowOpacity = 0.8

        if let title = content.title {
            self.title = title
        }

        if let pageIdString = content.page {
           self.view.backgroundColor = .contentDetailsBgColor
            let contentPageService = ContentPageService()
            contentPageService.fetchPage(pageId: pageIdString) { page, error in

                if page != nil {

                    self.page = page
                    self.loadWebPage()

                    if let video = page?.video {

                        if let sourceURL = URL(string: video.url) {
                            self.vrPlayer = VRPlayerViewController(url: sourceURL)
                             self.playButton.isHidden = false
                        }

                        if video.thumbnail != nil {
                            self.imageView.image = UIImage.videoPlaceHolderImage
                            let imageService = ImageService()
                            imageService.fetchVideoThumbnailImage(video: video) { video, _ in

                                if let imageFilePath = video.imageLocalFilePath {
                                    self.imageView.image = UIImage(contentsOfFile: imageFilePath)
                                } else {
                                    self.imageView.image = UIImage.videoPlaceHolderImage
                                }
                            }
                        } else {
                            self.imageView.image = UIImage.videoPlaceHolderImage
                        }

                    } else {
                        self.playerViewHeightConstraint.constant = 0
                    }

                } else {
                    self.showStandardAlert(message: error?.localizedDescription)
                }

                self.stopAnimating()
            }
        } else {
            if let urlString = content.url, let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                playerViewHeightConstraint.constant = 0
                webView.load(URLRequest(url: url))
                webView.allowsBackForwardNavigationGestures = true
            } else {
                showStandardAlert(message: ErrorMessages.errorToLoadScreen)
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

    func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.webViewHeight.constant = webView.scrollView.contentSize.height
            self.stopAnimating()
        }
    }

    func loadWebPage() {

        if let page = self.page {
            var content: String?

            if config.darkMode {
                content = page.darkModeContent
            } else {
                content = page.lightModeContent
            }

            if let contentDescription = content {
                self.webView.loadHTMLString(contentDescription, baseURL: URL(string: config.baseURL))
            }
        }
    }

    override func traitCollectionDidChange(_: UITraitCollection?) {
        loadWebPage()

    }

}
