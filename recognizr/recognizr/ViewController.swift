//
//  ViewController.swift
//  recognizr
//
//  Created by Yusuf ali cezik on 29.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import SwiftOCR

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let swiftOCRInstance = SwiftOCR()
        
        let myImage = UIImage(named: "kitap1")
        swiftOCRInstance.recognize(myImage!) { recognizedString in
            print(recognizedString)
        }
    }
    
    


}

