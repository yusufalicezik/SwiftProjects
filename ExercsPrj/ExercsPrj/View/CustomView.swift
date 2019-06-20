//
//  CustomView.swift
//  ExercsPrj
//
//  Created by Yusuf ali cezik on 20.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {

    @IBInspectable var mBorderColor : UIColor = UIColor.blue { //bunlar default renkleri, init istendiği için @IBInspectable ile değiştirilebilir
        didSet {
            self.setNeedsLayout() //update
        }
    }
    @IBInspectable var mBorderWidth : CGFloat = 1.0 {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var mBackgroundColor: UIColor = UIColor.blue {
        didSet {
            self.setNeedsLayout()
        }
    }
//    @IBInspectable var mCornerRadius : Bool = false {
//        didSet {
//            self.setNeedsLayout()
//        }
//    }
    
        @IBInspectable var mCornerRadius : CGFloat = 0.0 {
            didSet {
                self.setNeedsLayout()
            }
        }
    
    override func layoutSubviews() {
        self.backgroundColor = mBackgroundColor
        layer.borderWidth = CGFloat(mBorderWidth)
        layer.borderColor = mBorderColor.cgColor
        //layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        
//        if mCornerRadius {
//            layer.cornerRadius = layer.frame.width / 2
//        }else{
//            layer.cornerRadius = 0.0
//        }
        layer.cornerRadius = mCornerRadius
        
       
        
    }
}
