//
//  MesajVC.swift
//  Wots
//
//  Created by Yusuf ali cezik on 20.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class MesajVC: UIViewController {

    //
    var mesajGonderilenUser = User()
    //
    var mesajlar = [Mesaj]()
    
    
    ///
    var aktifField : UITextField?
    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    //
    @IBOutlet weak var mesajGonderilenIsimSoyisimLabel: UILabel!
    @IBOutlet weak var mesajGonderilenProfilResim: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mesajTextTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        mesajTextTextfield.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
   

        
        
   
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let _ = mesajGonderilenUser.name_surname {
            mesajGonderilenIsimSoyisimLabel.text = mesajGonderilenUser.name_surname
        }else{
            
        }
    }
    

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mesajGonderClicked(_ sender: Any) {
        if mesajTextTextfield.text != ""{
            let msj = Mesaj()
            msj.ow = "0"
            msj.owner = CurrentUserDefaults.currentUser.user.id!
            msj.to = mesajGonderilenUser.id!
            msj.text = mesajTextTextfield.text!
            mesajlar.append(msj)
            tableView.reloadData()
            //
            MessagesService.service.kullaniciylaMesajlariKaydet(mesaj: msj)
            //
        }
        self.view.endEditing(true)
    }
    
    
    
}

extension MesajVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mesajlar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MessagesCell {
            if mesajlar[indexPath.row].ow! == "0" { //gönderen bensem
                cell.textFieldGelenMesaj.backgroundColor = UIColor.clear
                cell.textFieldGelenMesaj.text = ""
                cell.textFieldGonderenMesaj.text = mesajlar[indexPath.row].text
            }else{ //gönderen karşısındakiyse
                //cell.textFieldGonderenMesaj.isHidden = true
                cell.textFieldGonderenMesaj.backgroundColor = UIColor.clear
                cell.textFieldGonderenMesaj.text = ""
                cell.textFieldGelenMesaj.text = mesajlar[indexPath.row].text
            }
                return cell
        }else{
            return UITableViewCell()
        }
    }
    
    
}


extension MesajVC : UITextFieldDelegate {
    
    ///
    @objc func returnTextView(gesture: UIGestureRecognizer) {
        guard activeField != nil else {
            return
        }
        
        activeField?.resignFirstResponder()
        activeField = nil
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        notifikasyonOlustur()
    }
    override func viewDidDisappear(_ animated: Bool) {
        notifikasyonKaldir()
    }
    
    func notifikasyonOlustur()
    {
        //Klavyenin görünüm durumlarına gore notifikasyonlar ekliyoruz
        NotificationCenter.default.addObserver(self, selector: #selector(klavyeGorundu(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(klavyeKaybolacak(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func notifikasyonKaldir()
    {
        //ViewController kaybolurken notifikasyonları kaldırıyoruz
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func klavyeGorundu(notification: NSNotification){
        // klavyenin gercek boyutunu hesaplıyoruz
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height + 20, right: 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.aktifField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    @objc func klavyeKaybolacak(notification: NSNotification)
    {
        //klavye kavbolurken eski posizyonlara getiriyoruz
        let info : NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardSize!.height, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        aktifField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        aktifField = nil
    }
    
    
}

