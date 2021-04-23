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

    @IBOutlet weak var mode: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(infoChanged), name: NSNotification.Name.SGPlayerDidChangeInfos, object: self)
   let videoURL = URL(string: "https://d3i6rif8o3vi8h.cloudfront.net/qa/student-life-summer-2019-low-res-577cbe9a-8b0e-469a-9077-9be04a3a655e.mp4")

        self.player?.videoRenderer().view = self.view
        self.player?.videoRenderer()?.displayMode = .vrBox
        self.player?.replace(with: videoURL)

        self.player?.play()

        print("PreferredFramesPerSecond:", self.player?.videoRenderer()?.preferredFramesPerSecond)
    }

    @IBAction func back(_ sender: Any) {

    }

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
