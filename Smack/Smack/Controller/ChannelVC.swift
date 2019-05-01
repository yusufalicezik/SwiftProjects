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
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){ //elle yazdık, istediğimiz controller a (segue) gönderebilmek için
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60 //açılan menünün ne kadar açılacağını belirler. 

    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
   

}
