//
//  CurrenyTxtField.swift
//  CustomComponents
//
//  Created by Yusuf ali cezik on 28.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

@IBDesignable //class ı storyboardda gösterebilmek için
class CurrenyTxtField: UITextField {

    override func prepareForInterfaceBuilder() { //ve gösterebilmek için bunu ekledik
        setUpViews()
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
      
   }
  
    
    func setUpViews(){
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.25)
        //layer.borderWidth = 1
        //layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        layer.cornerRadius = 10.0
        textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textAlignment = .center
        if let p = placeholder {
            let place = NSAttributedString(string: p, attributes: [.foregroundColor: UIColor.white])
            
            attributedPlaceholder = place
        }
        textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    

}
