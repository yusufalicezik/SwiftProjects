//
//  ProfilVC.swift
//  Wots
//
//  Created by Yusuf ali cezik on 19.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ProfilVC: UIViewController {

    
    ///
    @IBOutlet weak var profilHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var profilWidthConstraint: NSLayoutConstraint!
    ///
    
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
        takipEtveProfilAyarlarButton.setTitle("Profil Ayarları", for: UIControl.State.normal)
    }
    

    @IBAction func takipEtveProfilAyarlaButtonClicked(_ sender: Any) {
        //eğer currentUser id == profiline girdiğim kullanıcı id si; o zaman kendi profili ve takip et yerine
        //profil ayarları.(didLoadta yapıldı) Şimdilik kendi profilime girdiğim halini koşulsuz yapıyorum. (Kullanıcı aratırken tıklayıp profiline girmeden önce bilgileri bu controller a yollanır, bu duruma göre karşılaştırma, veri doldurma vs yapılır. Eğer ki bu bilgiler boşsa o zaman kendi profilim kabul ederim ve CurrentUserDefaultstan bilgileri alırım.)
        let profilAyarlarVC = UIStoryboard(name: "UtilsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ProfilAyarlarVC") as? ProfilAyarlarVC
        self.present(profilAyarlarVC!, animated: true, completion: nil)
    }
    

}
extension ProfilVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
