//
//  RangeSliderTableViewCell.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 06/01/2020.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import RangeSeekSlider
import UIKit

class RangeSliderTableViewCell: UITableViewCell, RangeSeekSliderDelegate {
    @IBOutlet var rangeSlider: RangeSeekSlider!
    @IBOutlet var rangeSliderLabel: UILabel!
    public var selectRange: ((String, CGFloat, CGFloat) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()

        rangeSlider.colorBetweenHandles = UIColor.rangeSliderTintColor
        rangeSliderLabel.textColor = UIColor.rangeSliderTitleColor
        rangeSliderLabel?.font = UIFont.rangeSliderTitleFont
        rangeSlider.minLabelFont = UIFont.rangeMinMaxLabelFont ?? UIFont()
        rangeSlider.maxLabelFont = UIFont.rangeMinMaxLabelFont ?? UIFont()

        rangeSlider.minLabelColor = UIColor.rangeSliderMinMaxColor
        rangeSlider.maxLabelColor = UIColor.rangeSliderMinMaxColor

        rangeSlider.initialColor = UIColor.rangeSliderTintColor
        rangeSlider.handleColor = UIColor.rangeSliderTintColor
        rangeSlider.handleBorderColor = UIColor.rangeSliderTintColor
    }

    /// Method to load data to the cell
    /// - Parameters:
    ///   - title: title of cell
    ///   - minimumScore: minimum data of slider
    ///   - maximumScore: maximum data of slider
    ///   - minimumSelectedScore: selected minimum value
    ///   - maximumSelectedScore: selected maximum value
    ///   - currency: currency type or not

    /// Method to load data to the cell
    /// - Parameters:
    ///   - title: title of cell
    ///   - limit: slider upper limit and lower limt as `MinMax`
    ///   - selected: selected upper limit and lower limt as `MinMax`
    ///   - currency: currency type or not
    func loadData(title: String, limit: MinMax, selected: MinMax, currency: Bool) {
        rangeSliderLabel.text = title
        rangeSlider.step = 1.0
        rangeSlider.enableStep = true
        rangeSlider.minValue = 1
        rangeSlider.minValue = CGFloat(limit.min)
        rangeSlider.maxValue = 1
        rangeSlider.maxValue = CGFloat(limit.max)
        rangeSlider.selectedMinValue = CGFloat(selected.min)
        rangeSlider.selectedMaxValue = CGFloat(selected.max)
        rangeSlider.selectedHandleDiameterMultiplier = 1.3
        rangeSlider.delegate = self
        if currency == true {
            rangeSlider.numberFormatter.numberStyle = .currency
            rangeSlider.numberFormatter.locale = Locale(identifier: "en_US")
        }
    }

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider == rangeSlider {
            if let selectThisRange = selectRange {
                selectThisRange(rangeSliderLabel.text ?? "", minValue, maxValue)
            }
        }
    }
}
