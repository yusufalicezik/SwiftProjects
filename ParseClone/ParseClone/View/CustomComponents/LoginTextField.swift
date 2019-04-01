//
//  LoginTextField.swift
//  ParseClone
//
//  Created by Yusuf ali cezik on 1.04.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit


class LoginTextField: UITextField {
    
  

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.backgroundColor=UIColor(red: 97, green: 137, blue: 152).cgColor
        self.layer.borderWidth=0
        self.layer.cornerRadius=18
        self.textColor=UIColor(red: 255, green: 255, blue: 0)
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 9)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds:bounds)
    }

}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

