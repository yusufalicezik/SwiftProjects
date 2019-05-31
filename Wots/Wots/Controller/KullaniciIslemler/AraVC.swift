//
//  AraVC.swift
//  Wots
//
//  Created by Yusuf ali cezik on 20.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class AraVC: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchEdittext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchEdittext.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        configViews()
        
    }
    
    func configViews(){
        searchEdittext.layer.cornerRadius = 10
        let bittiButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40.0))
        bittiButton.backgroundColor = #colorLiteral(red: 0.8325451016, green: 0.580083549, blue: 0.4307251275, alpha: 1)
        bittiButton.setTitle("Ara", for: .normal)
        bittiButton.setTitleColor(#colorLiteral(red: 0.3490196078, green: 0.3803921569, blue: 0.4235294118, alpha: 0.8785049229), for: .normal)
        bittiButton.addTarget(self, action: #selector(dismissKeyboard), for: UIControl.Event.touchUpInside)
        
        searchEdittext.inputAccessoryView = bittiButton
        
    }
    
  
        
    
    
    
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
        //Arama işlemleri
        FethcingService.service.bulunanKullanicilar = []
        FethcingService.service.kullaniciAra(searchEdittext.text!) { (bitti) in
            if bitti {
                self.tableView.reloadData()
            }else{
                print("hata")
            }
        }
        
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        FethcingService.service.bulunanKullanicilar = []
        FethcingService.service.kullaniciAra(textField.text!) { (bitti) in
            if bitti {
                self.tableView.reloadData()
            }else{
                print("hata")
            }
        }
    }
    
  
    

    


}
extension AraVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FethcingService.service.bulunanKullanicilar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = FethcingService.service.bulunanKullanicilar[indexPath.row].name_surname
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Log seçildi..\(indexPath.row)")
        let profilVC = storyboard!.instantiateViewController(withIdentifier: "ProfilVC") as? ProfilVC
        profilVC?.profileUser = FethcingService.service.bulunanKullanicilar[indexPath.row]
        
        self.present(profilVC!, animated: true, completion: nil)
    }
    
   
    
}

