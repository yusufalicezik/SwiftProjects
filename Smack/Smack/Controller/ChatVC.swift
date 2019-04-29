//
//  ChatVC.swift
//  Smack
//
//  Created by Yusuf ali cezik on 29.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //OUTLETS
    @IBOutlet weak var menuBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControl.Event.touchUpInside)
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!) //swipe ederek açılmasını/kapanmasını sağlamak için
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!) //ana ekrana  tıklandığında menünün kapanması için.

    }
    

 

}
