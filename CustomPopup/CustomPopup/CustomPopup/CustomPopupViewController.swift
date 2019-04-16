//
//  CustomPopupViewController.swift
//  CustomPopup
//
//  Created by Yusuf ali cezik on 15.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class CustomPopupViewController: UIViewController {

    @IBOutlet var parentView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var rootView: UIView!
    
    //veri gönderebilmek için;
    var popupDelegate: PopupDataDelegate?
    
    private enum DatePickerProperties: String {
        case TextColor = "textColor"
        case HighlightsToday = "highlightsToday"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = UIColor.white
        self.view.backgroundColor = color.withAlphaComponent(0.3)
        self.datePicker.setValue(UIColor.white, forKey: DatePickerProperties.TextColor.rawValue)
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.kapat))
        parentView.addGestureRecognizer(recognizer)
        rootView.layer.cornerRadius = 17
    }
    

  
    @IBAction func kaydetButtonClicked(_ sender: Any) {
        var secilenTarih:String{
            get{
                let formatter = DateFormatter()
                formatter.dateStyle = .full
                return formatter.string(from: datePicker.date)
            }
        }
        
        print(secilenTarih)
        popupDelegate?.tarihSec(secilenTarih: secilenTarih)
        self.dismiss(animated: false, completion: nil)

    }
    
    @objc func kapat(){
        self.dismiss(animated: false, completion: nil)

    }
    
    
}
