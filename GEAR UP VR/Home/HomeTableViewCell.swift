//
//  HomeTableViewCell.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 01/11/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet var containerView: UIView!

    @IBOutlet var tileImage: UIImageView!

    @IBOutlet var title: UILabel!

    @IBOutlet var details: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.cornerRadius = 5.0
        containerView.layer.borderWidth = 1.0
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 5

        tileImage.layer.cornerRadius = 5.0
        tileImage.layer.borderWidth = 1.0
        tileImage.layer.masksToBounds = true
        applyTheme()
    }

    func applyTheme() {
        contentView.backgroundColor = UIColor.homeViewBGColor
        containerView.backgroundColor = UIColor.homeTableViewCellContainerBGColor
        containerView.layer.shadowColor = UIColor.homeTableViewCellContainerShadowColor.cgColor
        containerView.layer.borderColor = UIColor.homeTableViewCellContainerBorderColor.cgColor
        tileImage.layer.borderColor = UIColor.tileImageBorderColor.cgColor
        title.textColor = UIColor.homeTableViewCellTitleColor
        details.textColor = UIColor.homeTableViewCellDetailsColor
        title.font = UIFont.homeTableViewCellTitleFont
        details.font = UIFont.homeTableViewCellDetailsFont
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadData(tile: DashboardTile, homeService: HomeService? = nil) {
        title.text = tile.title
        details.text = tile.tileDescription

        if let imageService = homeService {
            imageService.fetchActiveTileImage(tile: tile) { tile, _ in

                if let imageFilePath = tile?.imageLocalFilePath {
                    self.tileImage?.image = UIImage(contentsOfFile: imageFilePath)
                } else {
                    self.tileImage?.image = UIImage(named: "img_default_tile")
                }
            }
        }
    }
}
