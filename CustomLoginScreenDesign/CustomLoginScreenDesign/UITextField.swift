//
//  UITextField.swift
//  CustomLoginScreenDesign
//
//  Created by Yusuf ali cezik on 27.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

extension UITextField {
    func configure(
                   cornerRadius: CGFloat,
                   borderColor: UIColor? = nil,
                   backgroundColor: UIColor,
                   borderWidth: CGFloat? = nil) {
        if let borderWidth = borderWidth {
            self.layer.borderWidth = borderWidth

        }
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
    }
}
