//
//  ViewController.swift
//  CustomEdittext
//
//  Created by Yusuf ali cezik on 7.04.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
 
    
    @IBAction func eyeButtonClicked(_ sender: Any) {
        
        textfield.isSecureTextEntry.toggle()
    
    }
    
}

