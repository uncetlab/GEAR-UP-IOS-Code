//
//  SegmentedControl.swift
//  GEAR UP VR
//
//  Created by Shineeth Hamza on 23/03/20.
//  Copyright © 2020 Marlabs Inc. All rights reserved.
//

import UIKit

class SegmentedControl: UIView {
    var stackView: UIStackView = UIStackView()

    var items: [String] = [] {
        didSet {
            segmentsDidChanged()
        }
    }

    @IBInspectable
    var segmentColor: UIColor = UIColor.lightGray {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable
    var segmentTextColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }

    // The color to use for highlighting the currently selected segment.
    @IBInspectable
    var selectedSegmentColor: UIColor = UIColor.gray {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable
    var selectedSegmentTextColor: UIColor = UIColor.darkText {
        didSet {
            setNeedsDisplay()
        }
    }

    var segmentControlDidChangeValue: ((_ selectedSegmentIndex: Int) -> Void)?

    // ignored in momentary mode. returns last segment pressed. default is UISegmentedControlNoSegment until a segment is pressed
    // the UIControlEventValueChanged action is invoked when the segment changes via a user event. set to UISegmentedControlNoSegment to turn off selection
    var selectedSegmentIndex: Int {
        get {
            if let view = stackView.arrangedSubviews.first(where: { ($0 as? UIButton)?.isSelected == true }) {
                return stackView.arrangedSubviews.firstIndex(of: view) ?? UISegmentedControl.noSegment
            } else {
                return UISegmentedControl.noSegment
            }
        }

        set(value) {
            if value != UISegmentedControl.noSegment,
                value < stackView.arrangedSubviews.count {
                if let segment = stackView.arrangedSubviews[value] as? UIButton {
                    self.segmentDidSelect(sender: segment)
                }
            } else {
                self.unselectAllSegment()
            }
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initializeComponent()
    }

    /// to initialize stackview
    private func initializeComponent() {
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        clipsToBounds = true

        segmentsDidChanged()
    }

    /// function to recreate all segments
    private func segmentsDidChanged() {
        stackView.removeAllArrangedSubviews()
        for item in items {
            let view = UIButton(type: .custom)
            view.tag = items.firstIndex(of: item) ?? -1
            view.setTitle(item, for: .normal)
            view.addTarget(self, action: #selector(SegmentedControl.segmentDidSelect(sender:)), for: .touchUpInside)
            stackView.addArrangedSubview(view)
        }
    }

    /// will get called each time user click a segment
    /// - Parameter sender: <#sender description#>
    @objc private func segmentDidSelect(sender: UIButton) {
        UIView.animate(withDuration: 0.3,
                       animations: {
                           self.stackView.arrangedSubviews.forEach { view in
                               if let segment = view as? UIButton {
                                   segment.isSelected = (segment == sender)
                                   segment.backgroundColor = segment.isSelected ? self.selectedSegmentColor : self.segmentColor
                               }
                           }
                       }, completion: { _ in
                           if self.segmentControlDidChangeValue != nil {
                               self.segmentControlDidChangeValue!(sender.tag)
                           }
		})
    }

    private func unselectAllSegment() {
        stackView.arrangedSubviews.forEach { view in
            if let segment = view as? UIButton {
                segment.isSelected = false
                segment.backgroundColor = self.segmentColor
            }
        }
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_: CGRect) {
        layer.cornerRadius = frame.height / 2.0
        stackView.arrangedSubviews.forEach { view in
            if let segment = view as? UIButton {
                segment.setTitleColor(segmentTextColor, for: .normal)
                segment.setTitleColor(selectedSegmentTextColor, for: .selected)
                segment.backgroundColor = segment.isSelected ? selectedSegmentColor : segmentColor
            }
        }
    }
}

extension UIStackView {
    @discardableResult func removeAllArrangedSubviews() -> [UIView] {
        let removedSubviews = arrangedSubviews.reduce([]) { (removedSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
            return removedSubviews + [subview]
        }
        return removedSubviews
    }
}
