//
//  UNCTextField.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 22/01/2020.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import UIKit

enum UNCTextFieldStyle: String {
    case standard
}

class UNCTextField: UITextField {
    public var leftPaddingView: UIView?

    public init(frame: CGRect, style: UNCTextFieldStyle?) {
        super.init(frame: frame)

        if style == UNCTextFieldStyle.standard {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
            leftView = paddingView
            leftViewMode = .always
        }
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.searchfieldBorderColor.cgColor
        layer.cornerRadius = 5.0
        clearButtonMode = .whileEditing
        font = UIFont(name: "Roboto", size: 14.0)
        textColor = UIColor.searchTextFieldColor
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
