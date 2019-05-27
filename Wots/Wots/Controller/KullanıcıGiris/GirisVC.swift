//
//  GirisVC.swift
//  Wots
//
//  Created by Yusuf ali cezik on 16.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import SVProgressHUD


class GirisVC: UIViewController {

    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var girisButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    
    }
    override func viewWillAppear(_ animated: Bool) {
        //girisKontroluYap()
    }
    
    func configViews(){
        self.usernameLabel.layer.cornerRadius = 8
        self.passwordLabel.layer.cornerRadius = 8
        self.girisButton.layer.cornerRadius = 8
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(viewClicked))
        parentView.addGestureRecognizer(recognizer)
    }
    @objc func viewClicked(){
        //dismiss keyboard
        self.view.endEditing(true)

    }
    
    @IBAction func girisButtonClicked(_ sender: Any) {
        SVProgressHUD.show()
        guard let username = usernameLabel.text, let password = passwordLabel.text else { return }
        
           
            
        DataService.dataService.kullaniciGirisYap(username: username, password: password) { (girisDurumu) in
            if girisDurumu {
                SVProgressHUD.dismiss()
                let tabbarVC = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateInitialViewController()
                self.present(tabbarVC!, animated: true, completion: nil)
                    
            }else{
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Hata", message: "Kullanıcı adı ya da şifre yanlış, lütfen tekrar deneyin", preferredStyle: UIAlertController.Style.alert)
                let action = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                }
        }
        
    }
    
 
    @IBAction func kayitOlButtonClicked(_ sender: Any) {
        let kayitVc = storyboard?.instantiateViewController(withIdentifier: "KayitVC") as? KayitVC
        self.present(kayitVc!, animated: true, completion: nil)
    }
    
}
extension GirisVC {
    func girisKontroluYap(){
     //cıkıs yapılınca userdefaults silinecek.
        let user = DataService.dataService.girisYapanGetir()
        print("asd", user.name_surname!)
        print("asd", user.username!)

        if user.username! != "Null" {
            let loginStoryboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            let tabBarVc = loginStoryboard.instantiateInitialViewController()
            self.present(tabBarVc!, animated: false, completion: nil)
        }else{
            
        }
    }
}
