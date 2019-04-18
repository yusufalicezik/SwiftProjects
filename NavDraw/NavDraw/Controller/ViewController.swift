//
//  ViewController.swift
//  NavDraw
//
//  Created by Yusuf ali cezik on 17.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import Lottie


class ViewController: UIViewController {
    @IBOutlet weak var navMenu: UIView!
    @IBOutlet weak var navMenuLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuIcon: UIBarButtonItem!
    var menuDurumu=true
    
    
    var menuOn = false
    var hamburgerMenuButton:LOTAnimationView?
    let hamburgerMenuFrame = CGRect(x: -5, y: -10, width: 75, height: 75)
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         addHamburgerMenuButton(on: menuOn)
    }
    //
    func addHamburgerMenuButton (on:Bool) {
        if hamburgerMenuButton != nil {
            hamburgerMenuButton?.removeFromSuperview()
            hamburgerMenuButton = nil
        }
        
        
        let animation = on ? "buttonOff" : "buttonOn"
        
        hamburgerMenuButton = LOTAnimationView(name: animation)
        hamburgerMenuButton?.isUserInteractionEnabled = true
        hamburgerMenuButton?.frame = hamburgerMenuFrame
        hamburgerMenuButton?.contentMode = .scaleAspectFill
        
        
        addMenuToggleRecognizer()
        
        self.navigationController?.navigationBar.addSubview(hamburgerMenuButton!)
        //self.view.addSubview(hamburgerMenuButton!)
        
    }
    
    func addMenuToggleRecognizer (){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.toggleMenu(recognizer:)))
        
        tapRecognizer.numberOfTapsRequired = 1
        
        hamburgerMenuButton?.addGestureRecognizer(tapRecognizer)
        
    }
    
    @objc func toggleMenu (recognizer:UITapGestureRecognizer) {
        
        if !menuOn {
            self.navMenuLeftConstraint.constant = 0
            UIView.animate(withDuration: 0.4, animations: {
                self.view.layoutIfNeeded()
            })
            hamburgerMenuButton?.play(completion: { (success:Bool) in
                self.menuOn = true //menuyu ac
                self.addHamburgerMenuButton(on: self.menuOn)
            })
        }else{
            self.navMenuLeftConstraint.constant = -280
            UIView.animate(withDuration: 0.4, animations: {
                self.view.layoutIfNeeded()
            })
            hamburgerMenuButton?.play(completion: { (success:Bool) in
                self.menuOn = false //menuyu kapat
                self.addHamburgerMenuButton(on: self.menuOn)
            })
        }
        
        
    }
///
/*
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
 */
    
    @IBAction func randevuAlButonClicked(_ sender: Any) {
        
    }
    
}

