//
//  ProfilVC.swift
//  Wots
//
//  Created by Yusuf ali cezik on 19.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ProfilVC: UIViewController {

    
    
    var profileUser = User()
    var userDurumu = 0 //if durumunda 1 olacak.
    ///
    @IBOutlet weak var profilHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var profilWidthConstraint: NSLayoutConstraint!
    ///
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var messagesButton: UIButton!
    @IBOutlet weak var profilAciklamaLabel: UILabel!
    @IBOutlet weak var takipEtveProfilAyarlarButton: UIButton!
    @IBOutlet weak var stackTakipci: UIStackView!
    @IBOutlet weak var isimSoyisimLabel: UILabel!
    @IBOutlet weak var stackTakip: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profilResim: UIImageView!
    @IBOutlet weak var rootViewHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let _ = profileUser.username {
            //doluysa başkasının profili
            userDurumu = 1
            backButton.isHidden = false
            messagesButton.isHidden = false
            takipEtveProfilAyarlarButton.setTitle("Takip Et", for: UIControl.State.normal)
            isimSoyisimLabel.text = profileUser.name_surname

        }else{
            //boşsa kendisi
            userDurumu = 0
            backButton.isHidden = true
            messagesButton.isHidden = true
            takipEtveProfilAyarlarButton.setTitle("Profil Ayarları", for: UIControl.State.normal)
        }
        
    }
    

    @IBAction func takipEtveProfilAyarlaButtonClicked(_ sender: Any) {
        if userDurumu == 0 {
            //Profil ayarlarına girme işlemleri
            let profilAyarlarVC = UIStoryboard(name: "UtilsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ProfilAyarlarVC") as? ProfilAyarlarVC
            self.present(profilAyarlarVC!, animated: true, completion: nil)
        }else{
            //Takip etme işlemleri
        }
    }
    
    @IBAction func messagesButtonClicked(_ sender: Any) {
        //var olan user mesajlara gönderilecek.
        let mesajVC = UIStoryboard(name : "LoginStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MesajVC") as? MesajVC
        mesajVC?.mesajGonderilenUser = profileUser
        self.present(mesajVC!, animated: true, completion: nil)
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension ProfilVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //profildeki userın idsine göre postları getirilecek.
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostCell else { return UITableViewCell()}
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            let contentOffset = scrollView.contentOffset.y
            print("contentOffset: ", contentOffset)
            
            
            if(contentOffset < 0){
                self.rootViewHeightConstraint.constant = 181
                self.profilWidthConstraint.constant = 90
                self.profilHeightConstraint.constant =  90
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
                self.stackTakip.isHidden = false
                self.stackTakipci.isHidden = false
                
            }else if contentOffset > 200{
                self.rootViewHeightConstraint.constant = 90
                self.profilWidthConstraint.constant = 60
                self.profilHeightConstraint.constant =  60
                UIView.animate(withDuration: 0.5) {
                   self.view.layoutIfNeeded()
                }
                self.stackTakip.isHidden = true
                self.stackTakipci.isHidden = true
            }
            
            
        }
    }
    
   
    
    
}
extension ProfilVC {
    func configViews(){
        isimSoyisimLabel.text=CurrentUserDefaults.currentUser.user.name_surname!
    }
    
}
