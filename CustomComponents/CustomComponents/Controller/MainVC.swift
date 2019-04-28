//
//  ViewController.swift
//  CustomComponents
//
//  Created by Yusuf ali cezik on 28.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var usernameLabel: CurrenyTxtField!
    @IBOutlet weak var emailLabel: CurrenyTxtField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
     let kaydolButon = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60.0))
     kaydolButon.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
     kaydolButon.setTitle("Kayıt Ol", for: .normal)
     kaydolButon.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
     kaydolButon.addTarget(self, action: #selector(tiklama), for: UIControl.Event.touchUpInside)
        
    usernameLabel.inputAccessoryView = kaydolButon
    
        
        
    }
    
    @objc func tiklama(){
        print("clicked")
    }


}

