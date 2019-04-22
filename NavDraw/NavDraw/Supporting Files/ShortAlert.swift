//
//  ShortAlert.swift
//  NavDraw
//
//  Created by Yusuf ali cezik on 22.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import UIKit

class ShortAlert {
    static let sharedAlert = ShortAlert()
    
    func alertOlustur(baslik:String, mesaj: String)->UIAlertController{
        let alert = UIAlertController(title: baslik, message: mesaj, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        return alert
    }
}
