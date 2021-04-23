//
//  TagCollapsedView.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 07/12/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import UIKit

class TagCollapsedView: UIView {
    /// This method is to load tags into the view if available and calculate tag positions at runtime
    /// - Parameter tags: Array of tags
    func loadTags(tags: [String], truncateOnTagIndex: Int? = 4) {
        // clear existing tags before loading new
        subviews.forEach { $0.removeFromSuperview() }

        let initialXposition = 4
        let initialYposition = 4
        let xPositionDelta = 5
        let yPositionDelta = 5
        var tagWidth = 60
        let tagHeight = 20
        var xPosition = initialXposition
        var yPosition = initialYposition
        var count = tags.count
        if truncateOnTagIndex == 4 {
            if count >= 5 {
                count = 5
            }
        }
        count -= 1
        var tagName = ""
        for index in 0 ... count {
            if index == truncateOnTagIndex {
                tagName = "..."
            } else {
                tagName = tags[index]
            }

            // if tag overlap the parent view width, move tag to the next line
            if CGFloat(xPosition + tagWidth + 30) > bounds.width {
                xPosition = initialXposition
                yPosition += (tagHeight + yPositionDelta)
            }
            // calculate tagwidth based on content
            if let font = UIFont.visitNCListTagFont {
                tagWidth = Int(tags[index].widthOfString(usingFont: font)) + 16
            }
            // create tag and add as subview to the parent view
            let tag = buildTag(name: tagName, truncateOnTagIndex: truncateOnTagIndex,
                               frame: CGRect(x: xPosition,
                                             y: yPosition,
                                             width: tagWidth,
                                             height: tagHeight))
            addSubview(tag)

            // calculate x position for next tag
            xPosition += (tagWidth + xPositionDelta)
        }

        let parentViewComputedHeight = CGFloat(yPosition + tagHeight + yPositionDelta)
        heightAnchor.constraint(greaterThanOrEqualToConstant: parentViewComputedHeight).isActive = true
    }

    /// This method is to build tag
    /// - Parameter name: Tag name
    /// - Parameter frame: Tag frame
    func buildTag(name: String, truncateOnTagIndex: Int?, frame: CGRect) -> UIButton {
        let currentTag = UIButton()
        currentTag.frame = frame
        currentTag.layer.cornerRadius = 10
        currentTag.titleLabel?.font = UIFont.visitNCListTagFont
        currentTag.layer.borderWidth = 1.0
        if truncateOnTagIndex == 4 {
            currentTag.setTitleColor(UIColor.visitNCListTagTextColor, for: .normal)
            currentTag.backgroundColor = UIColor.visitNCListTagBGColor
            currentTag.layer.borderColor = UIColor.visitNCListTagBorderColor.cgColor
        } else {
            currentTag.setTitleColor(UIColor.collegeDetailPageTagTextColor, for: .normal)
            currentTag.backgroundColor = UIColor.collegeDetailPageTagBGColor
            currentTag.layer.borderColor = UIColor.collegeDetailPageTagBorderColor.cgColor
        }
        currentTag.setTitle(name, for: .normal)
        return currentTag
    }
}
