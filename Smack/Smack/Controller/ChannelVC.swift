//
//  ChannelVC.swift
//  Smack
//
//  Created by Yusuf ali cezik on 29.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60 //açılan menünün ne kadar açılacağını belirler. 

    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
   

}
