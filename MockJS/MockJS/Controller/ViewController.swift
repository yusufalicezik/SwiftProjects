//
//  ViewController.swift
//  MockJS
//
//  Created by Yusuf ali cezik on 5.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.dataService.kullaniciGirisYap(username: "yusufalicezik", password: "123456") { (bittiMi) in
            if bittiMi {
                print("basarili giris denemesi")
                if let currentUsername = CurrentUserDefaults.currentUser.userName {
                    print(currentUsername)
                }
            }else {
                print("yanlis deneme")
            }
        }
        
    }


}

