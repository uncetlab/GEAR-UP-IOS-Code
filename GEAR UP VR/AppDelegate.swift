//
//  AppDelegate.swift
//  GEAR UP VR
//
//  Created by Shineeth Hamza on 23/09/19.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import AVKit
import KeychainSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions
        _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        applyTheme()
        let config = Configuration()
		MSAppCenter.setLogLevel(.warning)
        MSAppCenter.start(config.appCenterKey, withServices: [
            MSAnalytics.self,
            MSCrashes.self
        ])
		MSAppCenter.setUserId(UIDevice.current.identifierForVendor?.uuidString)
		MSAppCenter.setCountryCode(Locale.current.currencyCode)

        if #available(iOS 13.0, *) {
            // iOS 13 and above versions uses scene delegate to launch the initial screen
        } else {
            // Create the window. Be sure to use this initializer and not the frame one.
            window = UIWindow(frame: UIScreen.main.bounds)
            prepareRootViewController(animated: false, window: window)
            window?.makeKeyAndVisible()
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient,
                                                            mode: AVAudioSession.Mode.moviePlayback,
                                                            options: [.mixWithOthers])
        } catch {
            print("error on setting sound mode: %@", error.localizedDescription)
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running,
        // this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func prepareRootViewController(errorStatusCode: APIStatusCode? = nil, animated: Bool = false, window: UIWindow? = nil, menu: [MenuElement]? = nil) {
        let keychain = KeychainSwift()
        var rootViewController: UIViewController?

        if let errCode = errorStatusCode {
            let viewController = ApplicationErrorViewController(errorStatusCode: errCode)
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.setNavigationBarHidden(true, animated: false)
            rootViewController = navigationController
        } else if !(keychain.getBool(Key.isAnalyticsSubmited.rawValue) ?? false) {
            let viewController = UserSelectionViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.setNavigationBarHidden(true, animated: false)
            rootViewController = navigationController
        } else if let filteredItems = menu?.filter({ menuElement -> Bool in menuElement.active == true }) {
            let items = filteredItems.sorted(by: { (item1, item2) -> Bool in item1.order < item2.order })
            let menuVC = MenuViewController(menus: items)
            rootViewController = menuVC
        } else {
            var stroryboardName: String
            switch config.university {
            case .mississippi:
                stroryboardName = "Launch_Screen_Mississippi"
            case .unc:
                stroryboardName = "Launch_Screen_UNC"
            }
            let storyboard = UIStoryboard(name: stroryboardName, bundle: nil)
            let viewController = storyboard.instantiateInitialViewController()
            rootViewController = HomeLaunchViewController()
            viewController?.view.frame = (rootViewController?.view.bounds)!
            rootViewController?.view.addSubview(viewController?.view ?? UIView())
        }
        var keyWindow: UIWindow?

        if window == nil {
            if #available(iOS 13.0, *) {
                // iOS 13 and above versions uses scene delegate to launch the initial screen
                let windowScene = UIApplication.shared
                    .connectedScenes
                    .filter { $0.activationState == .foregroundActive }
                    .first
                if let windowScene = windowScene as? UIWindowScene {
                    keyWindow = windowScene.windows.first
                }
            } else {
                keyWindow = self.window
            }
        } else {
            keyWindow = window
        }

        if keyWindow != nil {
            if animated {
                keyWindow?.backgroundColor = UIColor.lightGray
                UIView.animate(withDuration: 0.2,
                               delay: 0.0,
                               options: .curveEaseOut,
                               animations: {
                                   if let viewController = keyWindow?.rootViewController {
                                       viewController.view.alpha = 0.0
                                   }
                               },
                               completion: { (_: Bool) -> Void in

                                   rootViewController?.view.alpha = 0.0
                                   keyWindow?.rootViewController = rootViewController

                                   // Fade in
                                   UIView.animate(withDuration: 0.2,
                                                  delay: 0.0,
                                                  options: .curveEaseIn,
                                                  animations: {
                                                      if let viewController = keyWindow?.rootViewController {
                                                          viewController.view.alpha = 1.0
                                                      }
                                                  },
                                                  completion: nil)
				})

            } else {
                keyWindow?.rootViewController = rootViewController
            }
        }
    }

    func applyTheme() {
        UINavigationBar.appearance().tintColor = UIColor.navigationBarTintColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.navigationBarTintColor]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = UIColor.navigationBarBackgroundColor
        UINavigationBar.appearance().barTintColor = UIColor.navigationBarBackgroundColor
    }
}

extension UINavigationController {
    /// Extention to pass the viewcoroller supportedInterfaceOrientations to `UINavigationController`
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let visibleVC = visibleViewController {
            return visibleVC.supportedInterfaceOrientations
        }
        return super.supportedInterfaceOrientations
    }
}
