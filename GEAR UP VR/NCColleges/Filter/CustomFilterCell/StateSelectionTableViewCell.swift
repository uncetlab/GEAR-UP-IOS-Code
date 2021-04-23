//
//  StateSelectionTableViewCell.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 06/01/2020.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import DLRadioButton
import UIKit

class StateSelectionTableViewCell: UITableViewCell {
    @IBOutlet var radioButtonRow1: DLRadioButton?
    @IBOutlet var radioButtonRow2: DLRadioButton?
    public var selectState: ((String) -> Void)?
    var data: [String: String]?
    override func awakeFromNib() {
        super.awakeFromNib()

        radioButtonRow1?.indicatorColor = UIColor.stateSelectionRadioButtonTintColor
        radioButtonRow2?.indicatorColor = UIColor.stateSelectionRadioButtonTintColor

        radioButtonRow1?.setTitleColor(UIColor.stateSelectionRadioButtonTextTintColor, for: .normal)
        radioButtonRow2?.setTitleColor(UIColor.stateSelectionRadioButtonTextTintColor, for: .normal)

        radioButtonRow1?.titleLabel?.font = UIFont.stateSelectionFont
        radioButtonRow2?.titleLabel?.font = UIFont.stateSelectionFont

        radioButtonRow1?.addTarget(self, action: #selector(itemselected), for: .touchUpInside)
        radioButtonRow2?.addTarget(self, action: #selector(itemselected), for: .touchUpInside)
    }

    /// Method to load data to the cell
    /// - Parameter selectedValue: selected value
    func loadData(selectedValue: String) {
        if selectedValue == FilterConstants.stateTypeIn {
            radioButtonRow1?.isSelected = true
        } else {
            radioButtonRow2?.isSelected = true
        }
    }

    /// Method to select any radio button
    @objc func itemselected() {
        if let selectThisState = selectState {
            if radioButtonRow1?.isSelected == true {
                selectThisState(FilterConstants.stateTypeIn)
            } else {
                selectThisState(FilterConstants.stateTypeOut)
            }
        }
    }
}
