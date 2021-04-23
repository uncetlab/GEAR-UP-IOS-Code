//
//  MenuTableViewCell.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 28/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet var moreArrow: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        applyTheme()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func applyTheme() {
        contentView.backgroundColor = UIColor.menuViewControllerCellBgColor
        moreArrow.image = UIImage.menuMoreItemArrow?.tint(UIColor.menuViewControllerCellArrowTintColor)
        title.font = UIFont.menuMoreItemFont
    }
}
