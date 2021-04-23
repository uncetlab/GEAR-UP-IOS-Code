//
//  CareerTableViewCell.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 28/04/2020.
//  Copyright © 2020 Marlabs Inc. All rights reserved.
//

import UIKit

class CareerTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellBottomBorder: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func applyTheme() {

        cellBottomBorder.backgroundColor = UIColor.careersCellBottomBorderColor
        cellTitle.textColor = UIColor.careersCellTextColor

        cellImageView.layer.borderWidth = 1
        cellImageView.layer.masksToBounds = false
        cellImageView.layer.borderColor = UIColor.careersCellImageBorderColor.cgColor
        cellImageView.layer.cornerRadius = cellImageView.frame.height/2
        cellImageView.clipsToBounds = true

        self.backgroundColor = UIColor.careersCellBgColor
    }

    func loadData(item: Career?) {

        if let career = item {

            self.cellTitle.text = career.career

            if career.logo == nil {
              self.cellImageView?.image = UIImage(named: "img_default_tile")
            } else if let imageFilePath = career.imageLocalFilePath {
                cellImageView?.image = UIImage(contentsOfFile: imageFilePath)
            } else {
                self.cellImageView?.image = UIImage(named: "img_default_tile")
                CareerService.shared.fetchCareerLogo(tile: career) { tile, _ in
                    if let imageFilePath = tile?.imageLocalFilePath {
                        self.cellImageView?.image = UIImage(contentsOfFile: imageFilePath)
                    } else {
                        self.cellImageView?.image = UIImage(named: "img_default_tile")
                    }
                }
            }
        }

    }
}
