//
//  SignInViewController.swift
//  TabbedApp
//
//  Created by Yusuf ali cezik on 1.04.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit
import Parse
class SignInViewController: UIViewController {
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
     let delegate:AppDelegate=UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

       
    
        /*
        let parseObject=PFObject(className: "Fruits")
        parseObject["name"]="Apple"
        parseObject["calories"]=100
        parseObject.saveInBackground { (success, error) in
            if error != nil{
                print("hata"+(error?.localizedDescription)!)
            }else{
                print("başarılı")
            }
        }
         */
        
       
        
    }
    
    @IBAction func girisYapClicked(_ sender: Any) {
        if !userNameText.text!.isEmpty  && !passwordText.text!.isEmpty{
            
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { (user, error) in
                if error != nil{
                    let alert=self.delegate.alertOlustur("Hata", "Kullanıcı adı ya da şifre yanlış")
                    self.present(alert, animated: true, completion: nil)
                }else{
                    
                    //giriş yapılmışsa eğer verileri kaydet ve appdelegate de kontrol et.
                    UserDefaults.standard.set(self.userNameText.text!, forKey: "username")
                    UserDefaults.standard.synchronize()
                    
                    
                    let delegate:AppDelegate=UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberUser()
                    
                }
            }
            
            
            
        }else{
            let alert=self.delegate.alertOlustur("Hata", "Kullanıcı adı ya da şifre eksik")
            self.present(alert, animated: true, completion: nil)
        }
       
    }
    
    @IBAction func kayitOlClicked(_ sender: Any) {
        
        if !userNameText.text!.isEmpty  && !passwordText.text!.isEmpty{
        
        let user=PFUser()
        user.username=userNameText.text
        user.password=passwordText.text
            user.signUpInBackground { (success, error) in
                if error != nil{
                    print("Kayıt olma hatası")
                    let alert=self.delegate.alertOlustur("Hata", (error?.localizedDescription)!)
                    self.present(alert, animated: true, completion: nil)
                    
                   
                }else{
                    //giriş yapılmışsa eğer verileri kaydet ve appdelegate de kontrol et.
                    UserDefaults.standard.set(self.userNameText.text!, forKey: "username")
                    UserDefaults.standard.synchronize()
                    
                    
                   
                    self.delegate.rememberUser()
                }
            }
            
     
            
        }else{
           let alert=self.delegate.alertOlustur("Hata", "Kullanıcı adı ya da şifre eksik")
           self.present(alert, animated: true, completion: nil)
        }
    }
    
    
   
    
}
