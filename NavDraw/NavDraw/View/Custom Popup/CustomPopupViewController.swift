//
//  CustomPopupViewController.swift
//  NavDraw
//
//  Created by Yusuf ali cezik on 18.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class CustomPopupViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
  
    
   
   
  
    var secilenType:Int?
    var secilenString:String?
    var delegate:PopupDelegate?

    @IBOutlet var parentView: UIView!
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    //ör: doktor için doktor veritabanına gider doktorları alırız, vs.
    //bunun için hepsini burada yazmaktansa doktor için, hastnae için vs. farklı sınıflar oluşturulup veritabanındanDoktorlari al vs denilebilir.
    //şimdi statik yazalım
    
    var hastaneArray=["Isparta Şehir Hastanesi","Davraz Hastanesi","Özel Meddem Hastanesi","Yeni Hayat Hastanesi"]
    var bolumArray=["Genel Cerrahi","Dahiliye","Cildiye","Göz","Kulak Burun Boğaz","Nöroloji","Kalp Damar Cerrahisi"]
    var doktorArray=["Yusuf Ali Çezik","Rıdvan Kabak","Can Yardımcı","Emre Yaman"]
    var gunArray=["Haftaiçi","Haftasonu"]
    var saatArray=["08:00","10:00","11:00","12:00","13:00","15:00"]
    var secilenArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource=self
        pickerView.delegate=self
        self.pickerView.setValue(UIColor.white, forKey: "textColor")
        diziyiBelirle()
        

    }
    
 
    
    override func viewWillAppear(_ animated: Bool) {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.kapat))
        parentView.addGestureRecognizer(recognizer)
        rootView.layer.cornerRadius = 17
       
        
    }

    func diziyiBelirle(){
        switch secilenType {
        case 0:
            secilenArray=hastaneArray
        case 1:
             secilenArray=bolumArray
        case 2:
            secilenArray=doktorArray
        case 3:
            secilenArray=gunArray
        case 4:
            secilenArray=saatArray
        default:
             secilenArray=hastaneArray
            
        }
    }
    
    
    @IBAction func secButtonClicked(_ sender: Any) {
        delegate?.secilenString(secilenString: secilenString!, indisNo: secilenType!)
        kapat()
    }
    
    @IBAction func vazgecButtonClicked(_ sender: Any) {
       kapat()
    }
    @objc func kapat(){
         self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return secilenArray.count
    }
   
  
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return secilenArray[row]
       
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        secilenString = secilenArray[row]
    }
    
    
    
}
