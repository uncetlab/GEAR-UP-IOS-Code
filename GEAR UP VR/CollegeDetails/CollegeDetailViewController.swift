//
//  CollegeDetailViewController.swift
//  GEAR UP VR
//
//  Created by Ansarsha on 10/01/20.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import UIKit
import WebKit

class CollegeDetailViewController: BaseWebViewViewController {
    @IBOutlet var lineSeperatorView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var webViewHeight: NSLayoutConstraint!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var facebookButton: UIButton!
    @IBOutlet var twitterButton: UIButton!
    @IBOutlet var linkdinButton: UIButton!
    @IBOutlet var websiteButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet var tagView: TagCollapsedView!
    @IBOutlet var messageButton: UIButton!
    @IBOutlet var socialMediaView: UIView!
    @IBOutlet var tagViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var playerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var socialMediaViewHeightConstraint: NSLayoutConstraint!
    var universityID: String? = ""
    let nCCollegeService = NCCollegeService.shared
    var collegeDetails: CollegeDetails?
    var vrPlayer: VRPlayerViewController?

    var navigateToVideoPlayer: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        applyTheme()
        let backBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_arrow_back"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(backToCollegeListView))
        navigationItem.leftBarButtonItem = backBarButtonItem
        webView.uiDelegate = self
        webView.navigationDelegate = self
        edgesForExtendedLayout = []
        webView.isOpaque = false
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        showActivityIndicator()

        playButton.isHidden = true
        playButton.clipsToBounds = false
        playButton.layer.shadowColor = UIColor.darkGray.cgColor
        playButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        playButton.layer.shadowRadius = 5
        playButton.layer.shadowOpacity = 0.8
        fetchDataFromServer()
    }
    func fetchDataFromServer() {
       fetchCollegeDetails(universityID: universityID)
    }

    func setupRightBarButtonItem() {
        if collegeDetails?.email?.isEmpty ?? true == false {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.emailIcon,
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(emailAction(sender:)))
        }
    }

    func applyTheme() {
        view.backgroundColor = UIColor.collegeDetailPageBGColor
        scrollView.backgroundColor = UIColor.collegeDetailPageBGColor
        contentView.backgroundColor = UIColor.collegeDetailPageBGColor
        lineSeperatorView.backgroundColor = UIColor.collegeDetailPageLineSeperatorColor
        facebookButton.setImage(UIImage.facebookIcon, for: .normal)
        linkdinButton.setImage(UIImage.linkdinIcon, for: .normal)
        twitterButton.setImage(UIImage.twitterIcon, for: .normal)
        websiteButton.setImage(UIImage.websiteIcon, for: .normal)
        messageButton.setImage(UIImage.messageIcon, for: .normal)
        instagramButton.setImage(UIImage.instagramIcon, for: .normal)
        webView.isOpaque = false
        webView.backgroundColor = .clear

    }

    @objc func emailAction(sender _: UIBarButtonItem) {
        if let email = collegeDetails?.email {
            let bundleName = Bundle.main.displayName
            var urlComp = URLComponents(string: "mailto:\(email)")
            urlComp?.queryItems = [URLQueryItem(name: "subject", value: bundleName)]
            if let url = urlComp?.url, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showStandardAlert(message: ErrorMessages.emailNotConfigured)
            }
        }
    }

    @objc func backToCollegeListView(sender _: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    func fetchCollegeDetails(universityID: String?) {
        nCCollegeService.fetchCollegeDetails(universityID: universityID, completionHandler: { result, _ in
            self.stopAnimating()
            if let details = result {
                self.collegeDetails = details
                DispatchQueue.main.async {
                    self.setupPageWithCollegeDetails()
                    self.handleSocialMediaIcons()
                    self.setupRightBarButtonItem()
                }
            } else {
                self.showStandardAlert(message: "Unable to load data. Please try after some time.")
            }
        })
    }

    func setupPageWithCollegeDetails() {
        if let title = collegeDetails?.name {
            self.title = title
        }
        if let tags = collegeDetails?.tags {
            let tagsArray = tags.components(separatedBy: ",")
            if tagsArray.count > 0 {
                tagView.loadTags(tags: tagsArray, truncateOnTagIndex: tagsArray.count)
            }
        } else {
            tagViewHeightConstraint.constant = 0
        }

       loadWebPage()

        if let video = collegeDetails?.video {

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
            playerViewHeightConstraint.constant = 0
        }
        messageButton.isHidden = collegeDetails?.phoneNumber?.isEmpty ?? true
    }

    func handleSocialMediaIcons() {
        facebookButton.isHidden = collegeDetails?.facebookURL?.isEmpty ?? true
        twitterButton.isHidden = collegeDetails?.twitterURL?.isEmpty ?? true
        linkdinButton.isHidden = collegeDetails?.linkedinURL?.isEmpty ?? true
        websiteButton.isHidden = collegeDetails?.website?.isEmpty ?? true
        instagramButton.isHidden = true

        socialMediaView.isHidden = (facebookButton.isHidden &&
            twitterButton.isHidden &&
            linkdinButton.isHidden &&
            websiteButton.isHidden)

        if socialMediaView.isHidden {
            socialMediaViewHeightConstraint.constant = 0
        }
    }

    override func viewDidAppear(_ animated: Bool) {

        self.navigateToVideoPlayer = false
    }

    @IBAction func playButtonDidPressed(_: UIButton) {

        let menuViewController = self.tabBarController as? MenuViewController
        menuViewController?.changeOrientation = true

        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        if let player = self.vrPlayer {
            self.navigateToVideoPlayer = true
            self.navigationController?.pushViewController(player, animated: true)
        }
    }

    @IBAction func facebookButtonDidPressed(_: UIButton) {
        if let facebook = collegeDetails?.facebookURL {
            if let url = URL(string: facebook), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showStandardAlert(message: ErrorMessages.facebookNotConfigured)
            }
        }
    }

    @IBAction func twitterButtonDidPressed(_: UIButton) {
        if let twitter = collegeDetails?.twitterURL {
            if let url = URL(string: twitter), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showStandardAlert(message: ErrorMessages.twitterNotConfigured)
            }
        }
    }

    @IBAction func linkdinButtonDidPressed(_: UIButton) {
        if let linkdin = collegeDetails?.linkedinURL {
            if let url = URL(string: linkdin), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showStandardAlert(message: ErrorMessages.linkdinNotConfigured)
            }
        }
    }

    @IBAction func websiteButtonDidPressed(_: UIButton) {
        if let website = collegeDetails?.website {
            if let url = URL(string: website), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    @IBAction func instagramButtonDidPressed(_ sender: UIButton) {
    }
    @IBAction func messageButtonDidPressed(_: UIButton) {
        if let phoneNumber = collegeDetails?.phoneNumber {
            let regexString = phoneNumber.replacingOccurrences(of: "[^0-9\\+]", with: "", options: .regularExpression)
            if let url = URL(string: "sms:\(regexString)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showStandardAlert(message: ErrorMessages.messageNotConfigured)
            }
        }
    }

    func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.webView.backgroundColor = UIColor.webViewBGColor

            if self.navigateToVideoPlayer == false {
                self.webViewHeight.constant = webView.scrollView.contentSize.height
            }

            self.stopAnimating()
        }
    }

    func loadWebPage() {
        if let page = self.collegeDetails {
            showActivityIndicator()
            var content: String?

            if config.darkMode {
                content = page.darkModeContent
            } else {
                content = page.lightModeContent
            }

            if let collegeDescription = content {
                webView.loadHTMLString(collegeDescription, baseURL: URL(string: config.baseURL))
            }

        }
    }

    override func traitCollectionDidChange(_: UITraitCollection?) {

        loadWebPage()

    }
}
