//
//  Data_Extension.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 24/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation

extension Data {
    /// This method is to save data as image in the document directory
    /// - Parameter path: path to which the image should be saved
    func saveAsImageInDocumentDirectory(path: String) -> String {
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(path)
        fileManager.createFile(atPath: paths as String, contents: self, attributes: nil)

        return paths
    }
}
