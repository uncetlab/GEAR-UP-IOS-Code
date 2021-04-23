//
//  SceneDelegate.swift
//  GEAR UP VR
//
//  Created by Shineeth Hamza on 23/09/19.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        //        guard let _ = (scene as? UIWindowScene) else { return }

        guard let winScene = (scene as? UIWindowScene) else { return }

        //            // Create the root view controller as needed
        //            let vc = UserSelectionViewController()
        //            let nc = UINavigationController(rootViewController: vc)
        //            nc.setNavigationBarHidden(true, animated: false)
        // Create the window. Be sure to use this initializer and not the frame one.
        window = UIWindow(windowScene: winScene)

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.prepareRootViewController(animated: false, window: window)
        }

        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_: UIScene) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.applyTheme()
        }
    }

    func sceneDidEnterBackground(_: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
