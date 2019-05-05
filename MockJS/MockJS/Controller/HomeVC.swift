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
    @IBOutlet weak var navDrawerPopupWidthConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeEkle()
        if let name = CurrentUserDefaults.currentUser.userName {
            nameLabel.text = name
        }
    }
    
    func swipeEkle(){
        let recognizerSola = UISwipeGestureRecognizer(target: self, action: #selector(navKapat))
        recognizerSola.direction = .left
        parentView.addGestureRecognizer(recognizerSola)
    }
    
    @objc func navKapat(){
        navDrawerPopupWidthConstraint.constant = 0
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func cikisYapButtonClicked(_ sender: Any) {
       CurrentUserDefaults.currentUser.userID=nil
       CurrentUserDefaults.currentUser.userName=nil
       CurrentUserDefaults.currentUser.userImage=nil
        print(CurrentUserDefaults.currentUser.userID)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func hamburgerButtonClicked(_ sender: Any) {
        navDrawerPopupWidthConstraint.constant = self.view.bounds.width - 50
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
}
extension HomeVC : UIGestureRecognizerDelegate {
    
}
