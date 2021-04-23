//
//  NCCollegeMajorsTableViewCell.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 09/01/2020.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import UIKit

class NCCollegeMajorsTableViewCell: UITableViewCell {
    var currentMajor: Major?
    @IBOutlet var name: UILabel!
    @IBOutlet var checkMark: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

        name.textColor = UIColor.majorSelectionCellTextColor
        // Initialization code
    }

    /// Method to load data to the cell
    /// - Parameter major: current major data
    func loadData(major: Major) {
        currentMajor = major
        name.text = currentMajor?.title
    }
}
