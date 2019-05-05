//
//  ViewController.swift
//  MockJS
//
//  Created by Yusuf ali cezik on 5.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameLabel: CustomTextField!
    @IBOutlet weak var passwordLabel: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //DataService.dataService.kullaniciKaydiYap("emreaydin", "asdasd")
        
    }
    

    @IBAction func girisButtonClicked(_ sender: Any) {
        
        if let username = usernameLabel.text, let password = passwordLabel.text {
            
            DataService.dataService.kullaniciGirisYap(username: username, password: password) { (bittiMi) in
                if bittiMi {
                    print("basarili giris denemesi")
                    if let currentUsername = CurrentUserDefaults.currentUser.userName {
                        print(currentUsername)
                        self.usernameLabel.text = ""
                        self.passwordLabel.text = ""
                        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")
                        self.present(homeVC!, animated: true, completion: nil)
                    }
                }else {
                    print("yanlis deneme")
                }
            }
            
        }
        
       
        
    }
    
}

