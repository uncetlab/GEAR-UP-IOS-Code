//
//  CareerDetailViewController.swift
//  GEAR UP VR
//
//  Created by Ansarsha on 29/04/20.
//  Copyright © 2020 Marlabs Inc. All rights reserved.
//

import UIKit
import AVKit

class CareerDetailViewController: CollegeDetailViewController {
    let careerService = CareerService.shared
    var careerID: String? = ""
    var careerDetails: CareerDetails?

    init() {
        super.init(nibName: "CollegeDetailViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    override func fetchDataFromServer() {
        fetchCareerDetails(careerID: careerID)

    }

    /// This method is to fetch career details based on careerid(career_uid).
    /// - Parameter career_uid: career id
    /// - Parameter completionHandler: If success returns  career details, else returns error
    func fetchCareerDetails(careerID: String?) {
        careerService.fetchCareerDetails(careerID: careerID, completionHandler: { result, _ in
            self.stopAnimating()
            if let details = result {
                self.careerDetails = details
                DispatchQueue.main.async {
                    self.setupPageWithCareerDetails()
                    self.handleCareerSocialMediaIcons()
                    self.setupCareerPageRightBarButtonItem()
                }
            } else {
                self.showStandardAlert(message: "Unable to load data. Please try after some time.")
            }
        })
    }
    func setupCareerPageRightBarButtonItem() {
        if careerDetails?.email?.isEmpty ?? true == false {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.emailIcon,
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(emailAction(sender:)))
        }
    }
    @objc override func emailAction(sender _: UIBarButtonItem) {
        if let email = careerDetails?.email {
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

    /// This method is to setup Career detail page
    func setupPageWithCareerDetails() {
        if let title = careerDetails?.career {
            self.title = title
        }

        tagViewHeightConstraint.constant = 0
        loadWebPage()

        if let video = careerDetails?.video {

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
                imageView.image = UIImage.videoPlaceHolderImage
            }
        } else {
            playerViewHeightConstraint.constant = 0
        }
        messageButton.isHidden = careerDetails?.phoneNumber?.isEmpty ?? true
    }

    /// This method is to handle social media icons on career detail page
    func handleCareerSocialMediaIcons() {
        facebookButton.isHidden = careerDetails?.facebookURL?.isEmpty ?? true
        twitterButton.isHidden = careerDetails?.twitterURL?.isEmpty ?? true
        linkdinButton.isHidden = careerDetails?.linkedinURL?.isEmpty ?? true
        websiteButton.isHidden = careerDetails?.website?.isEmpty ?? true
        instagramButton.isHidden =  careerDetails?.instagramURL?.isEmpty ?? true
        socialMediaView.isHidden = (facebookButton.isHidden &&
            twitterButton.isHidden &&
            linkdinButton.isHidden &&
            websiteButton.isHidden)

        if socialMediaView.isHidden {
            socialMediaViewHeightConstraint.constant = 0
        }
    }

    @IBAction override func facebookButtonDidPressed(_: UIButton) {
        if let facebook = careerDetails?.facebookURL {
            if let url = URL(string: facebook), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showStandardAlert(message: ErrorMessages.facebookNotConfigured)
            }
        }
    }

    @IBAction override func twitterButtonDidPressed(_: UIButton) {
        if let twitter = careerDetails?.twitterURL {
            if let url = URL(string: twitter), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showStandardAlert(message: ErrorMessages.twitterNotConfigured)
            }
        }
    }

    @IBAction override func linkdinButtonDidPressed(_: UIButton) {
        if let linkdin = careerDetails?.linkedinURL {
            if let url = URL(string: linkdin), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showStandardAlert(message: ErrorMessages.linkdinNotConfigured)
            }
        }
    }
    @IBAction override func instagramButtonDidPressed(_ sender: UIButton) {
        if let instagram = careerDetails?.instagramURL {
            if let url = URL(string: instagram), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showStandardAlert(message: ErrorMessages.instagramNotConfigured)
            }
        }
    }

    @IBAction override func websiteButtonDidPressed(_: UIButton) {
        if let website = careerDetails?.website {
            if let url = URL(string: website), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    @IBAction override func messageButtonDidPressed(_: UIButton) {
        if let phoneNumber = careerDetails?.phoneNumber {
            let regexString = phoneNumber.replacingOccurrences(of: "[^0-9\\+]", with: "", options: .regularExpression)
            if let url = URL(string: "sms:\(regexString)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showStandardAlert(message: ErrorMessages.messageNotConfigured)
            }
        }
    }

    /// This method is to setup webview on career detail page
    override func loadWebPage() {
        if let page = self.careerDetails {
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
}
