//
//  ProfilAyarlarVC.swift
//  Wots
//
//  Created by Yusuf ali cezik on 22.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ProfilAyarlarVC: UIViewController {

    @IBOutlet weak var profilResmiImageView: UIImageView!
    @IBOutlet weak var isimSoyisimTextfield: UITextField!
    @IBOutlet weak var kullaniciAdiTextfield: UITextField!
    @IBOutlet weak var bioAciklamaTextfield: UITextField!
    @IBOutlet weak var sifteTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func kaydetButtonClicked(_ sender: Any) {
    }
    
    @IBAction func cikisYapButtonClicked(_ sender: Any) {
        DataService.dataService.cikisYap()
        let girisVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GirisVC") as? GirisVC
        self.present(girisVC!, animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

