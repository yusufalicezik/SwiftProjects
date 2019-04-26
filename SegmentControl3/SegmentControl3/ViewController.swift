//
//  ViewController.swift
//  SegmentControl3
//
//  Created by Yusuf ali cezik on 23.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import SwipeableTabBarController
import CircleMenu
class ViewController: UIViewController,  CircleMenuDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button = CircleMenu(
            frame: CGRect(x: 200, y: 200, width: 50, height: 50),
            normalIcon:"bb",
            selectedIcon:"bb",
            buttonsCount: 4,
            duration: 0.4,
            distance: 120)
        button.delegate = self
        button.layer.cornerRadius = button.frame.size.width / 2.0
        self.view.addSubview(button)

    }

    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int){

        print("\(atIndex) . buton seçildi..")
        
    }
    



}
