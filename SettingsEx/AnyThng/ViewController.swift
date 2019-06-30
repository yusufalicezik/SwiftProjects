//
//  ViewController.swift
//  AnyThng
//
//  Created by Yusuf ali cezik on 28.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var items = Array<String>()
    var selectedTitle:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        items = ["Profil", "Genel Ayarlar", "Wifi","Ekran Ayarları","Hakkında","Yazılım Güncelleme"]
       self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
    }

    func setupUI(){
        let bottomMenu = (Bundle.main.loadNibNamed("BottomMenu", owner: self, options: nil)?.first as? BottomMenu)!
        bottomMenu.translatesAutoresizingMaskIntoConstraints = false
        bottomMenu.mView.layer.cornerRadius = 10
        bottomMenu.mView.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        self.view.addSubview(bottomMenu)
        bottomMenu.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        bottomMenu.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30.0).isActive = true
        bottomMenu.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30.0).isActive = true
        bottomMenu.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30.0).isActive = true
        
    }

}
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 1{
            guard let cell = Bundle.main.loadNibNamed("FirstPersonCell", owner: self, options: nil)?.first as? FirstPersonCell else {
                return UITableViewCell()
            }
            cell.profileImage.layer.cornerRadius = cell.profileImage.frame.width / 2
            cell.nameLabel.text = "Yusuf Ali Çezik"
            cell.profileImage.image = UIImage(named: "person")
            
            return cell
            
        }
        
        else if  indexPath.row == 0 || indexPath.row == 2  || indexPath.row == 6  || indexPath.row == 10 || indexPath.row == 15 || indexPath.row == 21{
            guard let cell = Bundle.main.loadNibNamed("CustomCell2", owner: self, options: nil)?.first as? CustomCell2 else{
                return UITableViewCell()
            }
            cell.separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            return cell
        
            
        }else{
            var item : String
            var image : UIImage
            if indexPath.row == 0{
                item = items[0]
                image = images[0]!
            }else{
                print(indexPath.row)
                let dm=indexPath.row % items.count
                print(dm)
                item = items[dm]
                image = images[dm]!
            
            }
            guard let cell = Bundle.main.loadNibNamed("CustomCell1", owner: self, options: nil)?.first as? CustomCell1 else {
                return UITableViewCell()
            }
            cell.titleLabel.text = item
            cell.titleImageview.image = image
            if indexPath.row == 5  || indexPath.row == 9 || indexPath.row == 14 || indexPath.row == 20{
                cell.separatorInset = UIEdgeInsets(top: 1.0, left: 0.0, bottom: 0.0, right: 0.0)
            }
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dm=indexPath.row % items.count
        selectedTitle = items[dm]
        performSegue(withIdentifier: "goToDetailVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailVC"{
            let vc = segue.destination as? DetailsVC
            vc?.mTitle = selectedTitle
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

