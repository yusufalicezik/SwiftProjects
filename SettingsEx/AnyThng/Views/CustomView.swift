//
//  CustomView.swift
//  AnyThng
//
//  Created by Yusuf ali cezik on 29.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {

    @IBInspectable var mCornerRadius : CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        
        layer.cornerRadius = mCornerRadius
    }

  

}
