//
//  CustomXib.swift
//  XibCustomPin
//
//  Created by Yusuf ali cezik on 9.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class CustomXib: UIView {

    var onerilecekKonum:String?
    
    func onerConfig(onerilecekKonum:String){
        self.onerilecekKonum = onerilecekKonum
    }
    
    @IBAction func onerButtonClicked(_ sender: Any) {
        if let onerilecekKonum_ = self.onerilecekKonum {
            print(onerilecekKonum_)
        }
        
        self.removeFromSuperview() 
    }
    

}
