//
//  UIImageExtension.swift
//  GEAR UP VR
//
//  Created by Shineeth Hamza on 18/12/19.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import AVKit
import UIKit

extension UIImage {
    public convenience init?(videoUrl: String) {
        if let sourceURL = URL(string: videoUrl) {
            let asset = AVAsset(url: sourceURL)
            self.init(avasset: asset)
        } else {
            return nil
        }
    }

    public convenience init?(avasset: AVAsset) {
        let imageGenerator = AVAssetImageGenerator(asset: avasset)
        let time = CMTimeMake(value: 1, timescale: 1)
        do {
            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            self.init(cgImage: imageRef)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func tint(_ tintColor: UIColor?) -> UIImage {
        guard let tintColor = tintColor else { return self }
        return modifiedImage { context, rect in
            context.setBlendMode(.multiply)
            context.clip(to: rect, mask: self.cgImage!)
            tintColor.setFill()
            context.fill(rect)
        }
    }

    private func modifiedImage(draw: (CGContext, CGRect) -> Void) -> UIImage {
        // using scale correctly preserves retina images
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        // correctly rotate image
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        draw(context, rect)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        return newImage
    }

    /// Splash_Screen
    open class var logo: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "logo_mississippi")
        case .uncDark, .uncLight: return UIImage(named: "logo")
        }
    }

    open class var splashScreenBG: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "bg_user_type_selection_mississippi")
        case .uncDark, .uncLight: return UIImage(named: "bg_splash_screen")
        }
    }

    /// User_type_selection
    open class var userTypeSelectionBG: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "bg_user_type_selection_mississippi")
        case .uncDark, .uncLight: return UIImage(named: "bg_user_type_selection")
        }
    }

    open class var studentIcon: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_student")
        case .uncDark, .uncLight: return UIImage(named: "ic_student")
        }
    }

    open class var teacherIcon: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_teacher")
        case .uncDark, .uncLight: return UIImage(named: "ic_teacher")
        }
    }

    open class var parentIcon: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_parent")
        case .uncDark, .uncLight: return UIImage(named: "ic_parent")
        }
    }

    open class var nonTraditionalIcon: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_non_traditional")
        case .uncDark, .uncLight: return UIImage(named: "ic_non_traditional")
        }
    }

    open class var othersIcon: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_others")
        case .uncDark, .uncLight: return UIImage(named: "ic_others")
        }
    }

    /// HighSchool_selection
    open class var highSchoolSelectionBG: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "bg_user_type_selection_mississippi")
        case .uncDark, .uncLight: return UIImage(named: "bg_select_school")
        }
    }

    open class var searchArrow: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_school_submit")
        case .uncDark, .uncLight: return UIImage(named: "ic_school_submit")
        }
    }

    /// ApplicationErrorViewController
    open class var applicationErrorViewControllerMainImage: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "404img")
        case .uncDark, .uncLight: return UIImage(named: "404img")
        }
    }

    /// MenuViewController
    open class var menuMoreItemDefaultImage: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_default")
        case .uncDark, .uncLight: return UIImage(named: "ic_default")
        }
    }

    open class var menuMoreItemArrow: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_right_arrow")
        case .uncDark, .uncLight: return UIImage(named: "ic_right_arrow")
        }
    }

    open class var majorSelectionRadio: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "select_major_radio")
        case .uncDark, .uncLight: return UIImage(named: "select_major_radio")
        }
    }

    open class var majorSelectedRadio: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "selected_major_radio")
        case .uncDark, .uncLight: return UIImage(named: "selected_major_radio")
        }
    }

    open class var majorScreenArrow: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_selectmasters")
        case .uncDark, .uncLight: return UIImage(named: "ic_selectmasters")
        }
    }

    open class var filterCloseImage: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_filter_close")
        case .uncDark, .uncLight: return UIImage(named: "ic_filter_close")
        }
    }

    /// Home_page
    open class var videoPlaceHolderImage: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "img_360_video_placeholder")
        case .uncDark, .uncLight: return UIImage(named: "img_360_video_placeholder")
        }
    }

    /// Visit_NC_College
    open class var mapViewAccessoryButtonImage: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_rightarrow_white")
        case .uncDark, .uncLight: return UIImage(named: "ic_rightarrow_blue")
        }
    }

    open class var mapViewmarkerImage: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_place_mississippi")
        case .uncDark, .uncLight: return UIImage(named: "ic_place")
        }
    }

    /// College_detail_page
    open class var facebookIcon: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_fb_mississippi")
        case .uncDark, .uncLight: return UIImage(named: "ic_fb")
        }
    }

    open class var linkdinIcon: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_linkedin_mississippi")
        case .uncDark, .uncLight: return UIImage(named: "ic_linkedin")
        }
    }

    open class var twitterIcon: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_twitter_mississippi")
        case .uncDark, .uncLight: return UIImage(named: "ic_twitter")
        }
    }

    open class var websiteIcon: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_website_mississippi")
        case .uncDark, .uncLight: return UIImage(named: "ic_website")
        }
    }

    open class var emailIcon: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_mail_mississippi")
        case .uncDark, .uncLight: return UIImage(named: "ic_mail")
        }
    }

    open class var messageIcon: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_msg_mississippi")
        case .uncDark, .uncLight: return UIImage(named: "ic_msg")
        }
    }
    open class var instagramIcon: UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIImage(named: "ic_instagram_mississippi")
        case .uncDark, .uncLight: return UIImage(named: "ic_instagram")
        }
    }
}
