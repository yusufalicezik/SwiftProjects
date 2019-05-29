//
//  KayitVC.swift
//  Wots
//
//  Created by Yusuf ali cezik on 17.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import SVProgressHUD

class KayitVC: UIViewController {

    
    ///
    var aktifField : UITextField?
    //
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var adSoyadTxtField: UITextField!
    @IBOutlet weak var epostaTxtField: UITextField!
    @IBOutlet weak var kullaniciAdiTxtField: UITextField!
    @IBOutlet weak var sifreTxtField: UITextField!
    @IBOutlet weak var sifreTekrarTxtField: UITextField!
    @IBOutlet weak var girisButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        adSoyadTxtField.delegate = self
        epostaTxtField.delegate = self
        kullaniciAdiTxtField.delegate = self
        sifreTxtField.delegate = self
        sifreTekrarTxtField.delegate = self
  
        
        configViews()

    }
    
    
    @objc func returnTextView(gesture: UIGestureRecognizer) {
        guard activeField != nil else {
            return
        }
        
        activeField?.resignFirstResponder()
        activeField = nil
    }
    
    
    
    func configViews(){
        configComponents(views: [adSoyadTxtField,epostaTxtField, kullaniciAdiTxtField,sifreTxtField,sifreTekrarTxtField, girisButton])
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(viewClicked))
        parentView.addGestureRecognizer(recognizer)
        
    }
    

    
  
    
    func configComponents(views : [UIView]){
        for i in views {
            i.layer.cornerRadius = 8
        }
    }
    
    @objc func viewClicked(){
        //dismiss keyboard
        self.view.endEditing(true)
        
    }

    @IBAction func geriButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func GirisButtonClicked(_ sender: Any) { //KaydolButtonClicked
        SVProgressHUD.show()
        if adSoyadTxtField.text != "" && epostaTxtField.text != "" && kullaniciAdiTxtField.text != "" &&
        sifreTekrarTxtField.text != "" && sifreTxtField.text != "" &&
            sifreTxtField.text == sifreTekrarTxtField.text {
            DataService.dataService.kullaniciKaydiYap(user: User(username: kullaniciAdiTxtField.text!, password: sifreTxtField.text!, email: epostaTxtField.text!, name_surname: adSoyadTxtField.text!, profile_image: "https://tricky-photoshop.com/wp-content/uploads/2017/08/final-1.png")) { (kayit) in
                
                SVProgressHUD.dismiss()
                if kayit {
                    
                    self.dismiss(animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Hata", message: "Lütfen bilgileri kontrol edin", preferredStyle: UIAlertController.Style.alert)
                    let action = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        else{
             SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Hata", message: "Lütfen bilgileri kontrol edin", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//scrollview ile txtfieldlardaki sorunu çözme
extension KayitVC : UITextFieldDelegate {
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

