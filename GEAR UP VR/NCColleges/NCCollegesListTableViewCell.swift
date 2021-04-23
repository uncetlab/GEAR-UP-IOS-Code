//
//  NCCollegesListTableViewCell.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 07/12/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import UIKit

class NCCollegesListTableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var logo: UIImageView!
    @IBOutlet var tagView: TagCollapsedView!
    @IBOutlet var lineSeperatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        applyTheme()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    /// This mathod is to load the cell with data
    /// - Parameter tile: Current College data
    /// - Parameter nCCollegeService: NCCollegeService object for further service calls
    func loadData(item: College?) {
        if let college = item {
            title.text = college.name
            logo.layer.borderWidth = 1.0
            logo.layer.borderColor = UIColor.ncCollegeRowImageBorderColor.cgColor

            if let tags = college.tags?.components(separatedBy: ",") {
                tagView?.loadTags(tags: tags)
            }

            if let imageFilePath = college.imageLocalFilePath {
                // print("No need to call the API. The image is already saved")
                logo?.image = UIImage(contentsOfFile: imageFilePath)
            } else {
                NCCollegeService.shared.fetchCollegeLogo(tile: college) { tile, _ in

                    // print("Need to call the API. The image is not saved in the phone.")
                    if let imageFilePath = tile?.imageLocalFilePath {
                        self.logo?.image = UIImage(contentsOfFile: imageFilePath)
                    } else {
                        self.logo?.image = UIImage(named: "img_default_tile")
                    }
                }
            }
        }
    }

    func applyTheme() {
        title.textColor = UIColor.visitNCListTitleColor
        title.font = UIFont.visitNCListTitleFont
        lineSeperatorView.backgroundColor = UIColor.visitNCListLineSeperatorColor
        contentView.backgroundColor = UIColor.visitNCListCellBGColor
        backgroundColor = UIColor.visitNCListCellBGColor
    }
}
