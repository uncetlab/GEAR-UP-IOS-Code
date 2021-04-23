//
//  HighSchoolSearchTableViewCell.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 04/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import UIKit

class HighSchoolSearchTableViewCell: UITableViewCell {
    @IBOutlet var lineSeperatorView: UIView!
    @IBOutlet var title: UILabel!
    var school: School?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lineSeperatorView.backgroundColor = UIColor.tableViewLineSeperatorColor
    }

    /// This method is to load UI with School data
    /// - Parameter school: The school details which are about to be shown in the cell
    func loadData(school: School) {
        self.school = school
        title.text = self.school?.name
    }

    func applyTheme() {
        title.textColor = UIColor.highSchoolListTitleColor
        title.font = UIFont.highSchoolListTitleFont
        backgroundColor = UIColor.highSchoolSelectionCellBGColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
