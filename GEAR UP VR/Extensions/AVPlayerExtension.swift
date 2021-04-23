//
//  AVPlayerExtension.swift
//  GEAR UP VR
//
//  Created by Shineeth Hamza on 24/12/19.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import AVKit
import Foundation

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
