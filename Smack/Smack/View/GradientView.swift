//
//  GradientView.swift
//  Smack
//
//  Created by Yusuf ali cezik on 30.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    
    @IBInspectable var topColor : UIColor = UIColor.blue { //bunlar default renkleri, init istendiği için @IBInspectable ile değiştirilebilir
        didSet {
            self.setNeedsLayout() //update
        }
    }
   
    @IBInspectable var bottomColor : UIColor = UIColor.green {
        didSet {
            self.setNeedsLayout() //update
        }
    }
    
    
//    @IBInspectable var middleColor : UIColor?{ //bu şekilde optional da yapabiliriz ama unwrap ederek kullanmamız gerek
//        didSet{
//            self.setNeedsLayout()
//        }
//    }
//
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) //0, 0 olunca çarpraz geliyor 0.5 0.5 ortadan başlar
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds // or frame
        self.layer.insertSublayer(gradientLayer, at: 0) 
    }
}
