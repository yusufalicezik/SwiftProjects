//
//  YacAlert.swift
//  LoginWithPageview
//
//  Created by Yusuf ali cezik on 8.04.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import Foundation
import UIKit

class YacAlert:UIView{
    
    static let ycAlert = YacAlert()
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("YacAlert", owner: self, options: nil)
        commonInit()
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBAction func tamamButonClicked(_ sender: Any) {
        alertView.removeFromSuperview()
        
    }
    
    
    
    private func commonInit(){
       
        imgView.layer.cornerRadius=30
         
    }
    
    
    enum YacType{
        case success
        case failure
    }
    
    func showYacAlert(messg:String,yacType:YacType){
        switch yacType{
        case .success:
            title.text?=messg
            break
            
        case .failure: break
    }
        
        UIApplication.shared.keyWindow?.addSubview(alertView)
}

}
