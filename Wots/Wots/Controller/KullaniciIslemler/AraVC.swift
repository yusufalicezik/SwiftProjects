//
//  AraVC.swift
//  Wots
//
//  Created by Yusuf ali cezik on 20.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class AraVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchEdittext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        configViews()
        
    }
    
    func configViews(){
        searchEdittext.layer.cornerRadius = 10
        let bittiButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40.0))
        bittiButton.backgroundColor = #colorLiteral(red: 0.8325451016, green: 0.580083549, blue: 0.4307251275, alpha: 1)
        bittiButton.setTitle("Bitti", for: .normal)
        bittiButton.setTitleColor(#colorLiteral(red: 0.3490196078, green: 0.3803921569, blue: 0.4235294118, alpha: 0.8785049229), for: .normal)
        bittiButton.addTarget(self, action: #selector(dismissKeyboard), for: UIControl.Event.touchUpInside)
        
        searchEdittext.inputAccessoryView = bittiButton
        
    }
    
  
        
    
    
    
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    

    


}
extension AraVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Yusuf Ali çezik"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Log seçildi..\(indexPath.row)")
    }
    
   
    
}

