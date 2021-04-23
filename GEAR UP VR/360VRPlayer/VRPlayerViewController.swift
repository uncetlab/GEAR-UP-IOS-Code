//
//  VRPlayerViewController.swift
//  GearUP-VR360
//
//  Created by Harikrishnan on 14/05/2020.
//  Copyright © 2020 Harikrishnan. All rights reserved.
//

import UIKit

class VRPlayerViewController: UIViewController {

    let player: SGPlayer? = SGPlayer()
    let videoURL: URL?
    @IBOutlet weak var mode: UIButton!

    init(url: URL) {
        videoURL = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(infoChanged), name: NSNotification.Name.SGPlayerDidChangeInfos, object: self)

        if let url = videoURL {

                   self.player?.videoRenderer().view = self.view
                   self.player?.videoRenderer()?.displayMode = .VR
                   self.player?.replace(with: url)

        }

        //print("PreferredFramesPerSecond:", self.player?.videoRenderer()?.preferredFramesPerSecond)
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        self.player?.seek(to: CMTime.zero, result: nil)
        self.player?.play()
        self.setupFullscreen()
    }

    /// This method is to setup fullscreen mode
    func setupFullscreen() {
        UIApplication.shared.isIdleTimerDisabled = true
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    /// This method is to exit from fullscreen mode
    func resignFullscreen() {
        UIApplication.shared.isIdleTimerDisabled = false
        let menuViewController = self.tabBarController as? MenuViewController
        menuViewController?.changeOrientation = false

        let value = UIInterfaceOrientation.portrait.rawValue
         UIDevice.current.setValue(value, forKey: "orientation")

        self.player?.pause()
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }

    override var shouldAutorotate: Bool {
        return true
    }

    /// This method is to move back to the previous screen
    /// - Parameter sender: sender
    @IBAction func back(_ sender: Any) {
        self.resignFullscreen()
        self.navigationController?.popViewController(animated: true)
    }

    /// This method is to change mode from Carboard to Fullscreen & vice versa
    /// - Parameter sender: sender
    @IBAction func changeMode(_ sender: Any) {

        if self.player?.videoRenderer()?.displayMode == .vrBox {

            self.player?.videoRenderer()?.displayMode = .VR
            self.mode.setImage(UIImage(named: "vrBox"), for: .normal)
        } else {

            self.player?.videoRenderer()?.displayMode = .vrBox
            self.mode.setImage(UIImage(named: "VR"), for: .normal)
        }

    }

    @objc func infoChanged(notification: Notification) {
        print("Changed")
    }

}
