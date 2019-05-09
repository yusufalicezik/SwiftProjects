//
//  CustomXib.swift
//  XibCustomPin
//
//  Created by Yusuf ali cezik on 9.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CustomXib: UIView {

    
    @IBOutlet weak var konumLabel: UILabel!
    var onerilecekKonum:String?
    
    func onerConfig(onerilecekKonum:String){
        self.onerilecekKonum = onerilecekKonum
        konumLabel.text = onerilecekKonum
    }
    
    @IBAction func onerButtonClicked(_ sender: Any) {
        if let onerilecekKonum_ = self.onerilecekKonum {
            print(onerilecekKonum_)
            
        }
        
        
        self.removeFromSuperview()
    }
    

}
