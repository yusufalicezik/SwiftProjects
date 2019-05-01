//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Yusuf ali cezik on 30.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var txtUsernameLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         txtUsernameLabel.clearButtonMode = .whileEditing
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: UNWIND
            , sender:nil) //göndermek istediğim yere fonksiyonumu yazdım, kullanmak istediğim controller dan kntrl ile çekip exit e atadım ve fonksiyonumun adını seçtim. Daha sonra kullanmak istediğim controllerdaki butonClicked tanımlayıp içinde segue identifier ını yazdım
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.clearButtonMode = .whileEditing
    }

}

