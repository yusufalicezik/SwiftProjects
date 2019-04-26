//
//  SecondVC.swift
//  SegmentControl3
//
//  Created by Yusuf ali cezik on 24.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import SnapKit

class SecondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
    }
    
    func createViews(){
        var textFieldEmail:UITextField{
            let txtEmail = UITextField()
            txtEmail.editingRect(forBounds: CGRect(x: 70.0, y: 20.0, width: 300.0, height: 40.0))
            txtEmail.placeholder="E mail girin"
            txtEmail.backgroundColor = UIColor.blue
            return txtEmail
        }
        
        var textFieldPassword:UITextField{
            let txtEmail = UITextField()
            txtEmail.translatesAutoresizingMaskIntoConstraints = false
            txtEmail.placeholder="Şifre girin"
            txtEmail.backgroundColor = UIColor.blue
            return txtEmail
        }
        
        var girisYapButton:UIButton{
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Giriş yap", for: UIControl.State.focused)
            return button
        }
        
       view.addSubview(textFieldEmail)
       view.addSubview(textFieldPassword)
       view.addSubview(girisYapButton)
       
        textFieldEmail.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
        }
        
       
    }

    

}
