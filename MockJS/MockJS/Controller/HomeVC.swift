//
//  HomeVC.swift
//  MockJS
//
//  Created by Yusuf ali cezik on 5.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet var parentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navDrawerPopupWidthConstraint: NSLayoutConstraint!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        swipeEkle()
        if let name = CurrentUserDefaults.currentUser.userName {
            nameLabel.text = name
        }
    }
    
    func swipeEkle(){
        let recognizerSola = UISwipeGestureRecognizer(target: self, action: #selector(navKapat))
        recognizerSola.direction = .left
        parentView.addGestureRecognizer(recognizerSola)
        
       /* let recognizerTouch = UITapGestureRecognizer(target: self, action: #selector(navKapat))
        parentView.addGestureRecognizer(recognizerTouch)*/
        
        let recognizerSaga = UISwipeGestureRecognizer(target: self, action: #selector(navAc))
        recognizerSaga.direction = .right
        parentView.addGestureRecognizer(recognizerSaga)
        
    }
    
    @objc func navKapat(){
        navDrawerPopupWidthConstraint.constant = 0
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func navAc(){
        navDrawerPopupWidthConstraint.constant = self.view.bounds.width - 50
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func cikisYapButtonClicked(_ sender: Any) {
       CurrentUserDefaults.currentUser.userID=nil
       CurrentUserDefaults.currentUser.userName=nil
       CurrentUserDefaults.currentUser.userImage=nil
       
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func hamburgerButtonClicked(_ sender: Any) {
        navAc()
    }
    
}
extension HomeVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = menu[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapVC")
            self.present(mapVC!, animated: true, completion: nil)
            
        }
    }
    
    
}
