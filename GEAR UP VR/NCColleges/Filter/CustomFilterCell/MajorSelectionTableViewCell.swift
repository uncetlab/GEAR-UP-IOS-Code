//
//  MajorSelectionTableViewCell.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 07/01/2020.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import UIKit

class MajorSelectionTableViewCell: UITableViewCell {
    @IBOutlet var arrow: UIImageView!
    @IBOutlet var bottomSeparator: UIView!
    @IBOutlet var topSeparator: UIView!
    @IBOutlet var majorTitle: UILabel!
    @IBOutlet var majorsCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        majorTitle.textColor = UIColor.majorCellTitleColor
        majorsCount.textColor = UIColor.majorsCountColor

        majorTitle.font = UIFont.majorsTitleFont ?? UIFont()
        majorsCount.font = UIFont.majorsCountFont ?? UIFont()

        topSeparator.backgroundColor = UIColor.separatorBackgroundColor
        bottomSeparator.backgroundColor = UIColor.separatorBackgroundColor
        arrow.image = UIImage.majorScreenArrow
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
