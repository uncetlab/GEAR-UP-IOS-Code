//
//  UserSelectionTableViewCell.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 03/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import UIKit

class UserSelectionTableViewCell: UITableViewCell {
    @IBOutlet var bgView: UIView!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var userTypeLabel: UILabel!
    var userType: UserTypeElement?
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
    }

    ///  This method is to load UI with User type data & proper cell styling
    /// - Parameter type: The user type details  which are about to be shown in the cell
    func loadData(type: UserTypeElement) {
        userType = type
        userTypeLabel.text = userType?.title

        if let currentImage = userType?.getImage() {
            icon.image = currentImage
        }
    }

    func applyTheme() {
        bgView.layer.cornerRadius = 10.0
        bgView.layer.borderWidth = 1.0
        bgView.layer.borderColor = UIColor.clear.cgColor
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.userTypeCellBGColor
        userTypeLabel.textColor = UIColor.userTypeTitleColor
        userTypeLabel.font = UIFont.userTypeTitleFont
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
