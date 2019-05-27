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

