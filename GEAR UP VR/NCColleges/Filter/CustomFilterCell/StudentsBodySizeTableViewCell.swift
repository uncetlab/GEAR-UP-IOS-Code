//
//  StudentsBodySizeTableViewCell.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 07/01/2020.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import DLRadioButton
import UIKit

class StudentsBodySizeTableViewCell: UITableViewCell {
    @IBOutlet var cellTitle: UILabel!
    @IBOutlet var buttonsContainer: UIView!
    @IBOutlet var buttonsContainerHeight: NSLayoutConstraint!

    @IBOutlet var sizeClearButton: UIButton!
    @IBOutlet var bodySizeSeparator: UIView!
    var items: [[String: Any]]?
    public var selectSize: ((MinMax?) -> Void)?
    public var clearSelectSize: (() -> Void)?
    var selectedRadioButton: DLRadioButton?
    override func awakeFromNib() {
        super.awakeFromNib()

        cellTitle.textColor = UIColor.bodySizeTitleColor
        cellTitle.font = UIFont.bodySizeTitleFont
        bodySizeSeparator.backgroundColor = UIColor.separatorBackgroundColor
        sizeClearButton.setTitleColor(UIColor.sizeClearButtonTintColor, for: .normal)
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let buttonSpacing = CGFloat(15.0)
        let buttonWidth: CGFloat = (buttonsContainer.frame.width / 2) - buttonSpacing
        for subview in buttonsContainer.subviews {
            if let radioButton = subview as? DLRadioButton {
                for constraint in radioButton.constraints where constraint.firstAttribute == .width {
                    constraint.isActive = false
                }

                radioButton.widthAnchor
                    .constraint(equalToConstant: buttonWidth)
                    .isActive = true
            }
        }
    }

    /// Method to load data to the cell
    /// - Parameter items: items to be displayed
    /// - Parameter selectedMinValue: selected minimum value
    /// - Parameter selectedMaxValue: selected maximum value
    func loadData(items: [[String: Any]], selectedRange: MinMax?) {
        self.items = items
        var index = 0
        var aboveItem: UIView?
        let buttonSpacing = CGFloat(15.0)
        let buttonHeight: CGFloat = 28.0
        var previousButton: DLRadioButton?
        var firstRadioButton: DLRadioButton?

        if buttonsContainer.subviews.count > 0 {
            for item in buttonsContainer.subviews {
                item.removeFromSuperview()
            }
        }

        for item in items {
            let radioButton: DLRadioButton = DLRadioButton()

            if index == 0 {
                firstRadioButton = radioButton
            } else {
                firstRadioButton?.otherButtons.append(radioButton)
            }

            if let range = item["range"] as? MinMax,
                range == selectedRange {
                selectedRadioButton = radioButton
                radioButton.isSelected = true
            } else {
                radioButton.isSelected = false
            }

            radioButton.contentHorizontalAlignment = .left
            radioButton.tag = index
            radioButton.setTitle(item["title"] as? String, for: .normal)
            radioButton.titleLabel?.font = UIFont.bodySizeOptionFont
            radioButton.titleLabel?.textAlignment = NSTextAlignment.left
            radioButton.setTitleColor(UIColor.bodySizeOptionColor, for: .normal)
            radioButton.indicatorColor = UIColor.bodySizeOptionTintColor
            radioButton.addTarget(self, action: #selector(itemselected), for: .touchUpInside)

            radioButton.translatesAutoresizingMaskIntoConstraints = false
            buttonsContainer.addSubview(radioButton)

            if index % 2 == 0 {
                NSLayoutConstraint.activate([
                    radioButton.leadingAnchor
                        .constraint(equalTo: buttonsContainer.leadingAnchor, constant: buttonSpacing),
                    radioButton.topAnchor
                        .constraint(equalToSystemSpacingBelow: aboveItem?.bottomAnchor ?? buttonsContainer.topAnchor,
                                    multiplier: 1.0),
                    radioButton.heightAnchor
                        .constraint(equalToConstant: buttonHeight)
                ])

                previousButton = radioButton

            } else {
                NSLayoutConstraint.activate([
                    radioButton.leadingAnchor
                        .constraint(equalToSystemSpacingAfter: previousButton?.trailingAnchor ?? buttonsContainer.leadingAnchor,
                                    multiplier: 1.0),
                    radioButton.topAnchor
                        .constraint(equalToSystemSpacingBelow: aboveItem?.bottomAnchor ?? buttonsContainer.topAnchor,
                                    multiplier: 1.0),
                    radioButton.heightAnchor
                        .constraint(equalToConstant: buttonHeight)
                ])
                aboveItem = radioButton
            }

            index += 1
        }

        buttonsContainerHeight.constant = ((buttonHeight + CGFloat(8)) * CGFloat(items.count / 2)) + 8
    }

    @IBAction func clearStudentCapacity(_: Any) {
        if let thisRadioButton = selectedRadioButton {
            thisRadioButton.isSelected = false
            if let clearSelectSize = self.clearSelectSize {
                clearSelectSize()
            }
        }
    }

    /// Method to select any item and return the data to parent view
    /// - Parameter sender: sender
    @objc func itemselected(sender: DLRadioButton) {
        selectedRadioButton = sender
        if let data = items,
            sender.tag < data.count {
            let item = data[sender.tag]
            if let selectStudentsSize = selectSize {
                selectStudentsSize(item["range"] as? MinMax)
            }
        }
    }
}
