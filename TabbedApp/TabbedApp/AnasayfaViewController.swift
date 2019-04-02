//
//  FirstViewController.swift
//  TabbedApp
//
//  Created by Yusuf ali cezik on 1.04.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit
import Parse

class AnasayfaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    var postArray=[Post]()
    

    let delegate:AppDelegate=UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate=self
        tableView.dataSource=self
        
        verileriGetir()
        
    }
    
    @objc func verileriGetir(){
        
        postArray.removeAll(keepingCapacity: false)
        
        
        let query = PFQuery(className: "Posts")
        query.addDescendingOrder("createdAt") //en son eklenen ilk gösterilsin
        query.findObjectsInBackground { (objects, hata) in
            if hata != nil {
                print("hata")
            }else{
                if objects!.count>0 {
                for i in objects!{
                    let tempPost=Post()
                    tempPost.postSahibi=i.object(forKey: "postSahibi") as? String
                    tempPost.postUuid=i.object(forKey: "postuuid") as? String
                    tempPost.postAciklama=i.object(forKey: "aciklama") as? String
                    tempPost.postImage=i.object(forKey: "postResim") as? PFFileObject
                    
                    self.postArray.append(tempPost)
                    }
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    
    
    @IBAction func cikisYapClicked(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert=self.delegate.alertOlustur("Hata", "Çıkış yapılırken hata oluştu, internet bağlantınızın kontrol edin")
                self.present(alert, animated: true, completion: nil)
            }else{
                //çıkış yapılınca telefon hafızasındaki kullanıcı silinsin.
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.synchronize()
                
              
                //çıkış yapılmış ise benim giriş ekranımı değiştir.
                //veriler silindiği için boş dönecek otomatik giriş ekranı login ekranı olacak.
                self.delegate.rememberUser()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
       return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as! FeedCell
        
        cell.usernameText.text=postArray[indexPath.row].postSahibi
        cell.postAciklama.text=postArray[indexPath.row].postAciklama
        cell.uuidLabel.text=postArray[indexPath.row].postUuid
        
        postArray[indexPath.row].postImage?.getDataInBackground(block: { (data, error) in
            if error != nil {
                print("hata")
            }else{
                cell.postImage.image=UIImage(data: data!)
            }
        })
        
        return cell
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(AnasayfaViewController.verileriGetir), name: NSNotification.Name(rawValue: "newPost"), object: nil)
    }
    
}

