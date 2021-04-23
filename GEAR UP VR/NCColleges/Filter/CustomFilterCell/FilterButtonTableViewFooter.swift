//
//  FilterButtonTableViewCell.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 07/01/2020.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import UIKit

class FilterButtonTableViewFooter: UIView {
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var separatorView: UIView!
    /// IBAction method to reset filters
    /// - Parameter sender: <#sender description#>
    @IBAction func resetAction(_: Any) {
        if let resetAllFilters = resetFilter {
            resetAllFilters()
        }
    }

    public var resetFilter: (() -> Void)?
    public var applyFilters: (() -> Void)?

    /// IBAction method to apply filters
    /// - Parameter sender: sender
    @IBAction func apply(_: Any) {
        if let applyAllFilters = applyFilters {
            applyAllFilters()
        }
    }

    @IBOutlet var applyButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        applyButton.layer.cornerRadius = 5.0
        applyButton.layer.borderColor = UIColor.clear.cgColor
        applyButton.layer.borderWidth = 1.0
        applyButton.backgroundColor = UIColor.filterApplyButtonBgColor
        applyButton.setTitleColor(UIColor.filterApplyButtonTintColor, for: .normal)
        separatorView.backgroundColor = UIColor.separatorBackgroundColor
    }
}
