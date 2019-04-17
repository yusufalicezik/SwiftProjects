//
//  ViewController.swift
//  NavDraw
//
//  Created by Yusuf ali cezik on 17.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var navMenu: UIView!
    @IBOutlet weak var navMenuLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuIcon: UIBarButtonItem!
    var menuDurumu=true
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }


    @IBAction func menuIconClicked(_ sender: Any) {
        
        if menuDurumu{
            //menuyu ac
            self.navMenuLeftConstraint.constant = 0
            self.menuIcon.image = UIImage(named: "tersMenu")
    
        }else{
            //menuyu kapat
            self.navMenuLeftConstraint.constant = -280
            self.menuIcon.image = UIImage(named: "duzMenu")
        
        }
        menuDurumu = !menuDurumu
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
}

