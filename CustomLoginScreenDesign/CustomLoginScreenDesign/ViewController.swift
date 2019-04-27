//
//  ViewController.swift
//  CustomLoginScreenDesign
//
//  Created by Yusuf ali cezik on 27.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: ATCTextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var girisButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        textFieldEmail.configure(cornerRadius: textFieldEmail.frame.height / 4,
                                borderColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                                backgroundColor:#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                                borderWidth: 0.0)
        textFieldEmail.clipsToBounds = true
        
        
        
        
        passwordTextfield.configure(cornerRadius: passwordTextfield.frame.height / 4,
                                 borderColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                                 backgroundColor:#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                                 borderWidth: 0.0)
        passwordTextfield.clipsToBounds = true
     

        
        
        girisButton.layer.cornerRadius = girisButton.frame.height / 4
        girisButton.clipsToBounds = true
        
        self.hideKeyboardWhenTappedAround()
        
        
        
        girisButton.addTarget(self, action: #selector(butonTik), for: UIControl.Event.touchUpInside)
        
        
    }
    
    @objc func butonTik(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }


}

