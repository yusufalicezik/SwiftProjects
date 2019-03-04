//
//  ViewController.swift
//  AlertProject
//
//  Created by Yusuf ali cezik on 4.03.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordFirstText: UITextField!
    @IBOutlet weak var passwordSecondText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func kayitOlButonClicked(_ sender: Any) {
        if(usernameText.text=="" || usernameText.text==" "){
            alertOlustur(gelenBaslik: "Hata", gelenMesaj: "Kullanıcı adı boş geçilemez")
        }else if(passwordFirstText.text=="" || passwordSecondText.text==""){
            alertOlustur(gelenBaslik: "Hata", gelenMesaj: "Şifre boş geçilemez")
        }else if(!(passwordFirstText.text==passwordSecondText.text)){
            alertOlustur(gelenBaslik: "Hata", gelenMesaj: "Şifreler eşleşmiyor")
        }else{
            alertOlustur(gelenBaslik: "Başarılı", gelenMesaj: "Kullanıcı kaydı başarıyla yapıldı")
        }
    }
    
    
    
    @IBAction func buttonClicked(_ sender: Any) {
        
        //swift 4.2 için geçerli
        
        let alert=UIAlertController(title: "Hata", message: "Kullanıcı adı yanlış", preferredStyle: UIAlertController.Style.alert)
        
        
        //handler(nil yazan) eğer bu tuşa tıklandığında yeni bir şey olmasını istiyorsak(yeni aktiivte açma vs)
        let okButon=UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
    
    
        alert.addAction(okButon)
        
        //completion: bu işlem bitince bir şey yapılsın mı?
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func alertOlustur(gelenBaslik:String, gelenMesaj:String){
        let alert=UIAlertController(title: gelenBaslik, message:gelenMesaj , preferredStyle: UIAlertController.Style.alert)
        
        let okButon=UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButon)
        self.present(alert, animated: true, completion: nil)
    }
    
}

