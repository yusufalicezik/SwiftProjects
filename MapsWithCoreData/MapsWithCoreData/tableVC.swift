//
//  tableVC.swift
//  MapsWithCoreData
//
//  Created by Yusuf ali cezik on 30.03.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
class tableVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    
    @IBOutlet weak var tableView: UITableView!
    
    var kayitlar=[Yer]()
    
    var secilenKayit=Yer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate=self
        self.tableView.dataSource=self
        
        kaydedilenYerleriGetir()
        
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(tableVC.kaydedilenYerleriGetir), name: NSNotification.Name(rawValue: "newPlace"), object: nil)
        
        //eğer bi yenileme olmuşsa verileri silip tekrar çekecek.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kayitlar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        
        cell.textLabel?.text=kayitlar[indexPath.row].baslik
        
        
        return cell
    }
    

    @IBAction func addButtonClicked(_ sender: Any) {
        secilenKayit.baslik=""
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        secilenKayit=kayitlar[indexPath.row]
        performSegue(withIdentifier: "toMapVC", sender:nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="toMapVC"{
            let destinationVC=segue.destination as! mapVC
            destinationVC.secilenKayit=self.secilenKayit
            
        }
        
    }
    
    
   @objc func kaydedilenYerleriGetir(){
        kayitlar.removeAll(keepingCapacity: false)
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        
        let sonucIstek=NSFetchRequest<NSFetchRequestResult>(entityName: "KaydedilenYerler")
        sonucIstek.returnsObjectsAsFaults=false //tek tek çekip dizi içine atmak için istekte bulunduk
        
        do{
            let sonuclar=try context.fetch(sonucIstek)
            if(sonuclar.count>0){
                
                 for sonuc in sonuclar as! [NSManagedObject]{
                    
                    var geciciYer=Yer()
                    
                   
                    
                    if let gelenBaslik = sonuc.value(forKey: "title") as? String{
                        geciciYer.baslik=gelenBaslik
                    }
                    if let gelenAciklama = sonuc.value(forKey: "subtitle") as? String{
                        geciciYer.aciklama=gelenAciklama
                    }
                   
                    if let gelenLat = sonuc.value(forKey: "latitude") as? Double{
                        geciciYer.location.latitude=gelenLat
                    }
                    if let gelenLong = sonuc.value(forKey: "longitude") as? Double{
                        geciciYer.location.longitude=gelenLong
                    }
                    
                   
                    kayitlar.append(geciciYer)
                
                }
                 self.tableView.reloadData()
                
                
                
            }
            
            
            
        }catch{
            print("veri çekme hata")
        }
        
        
    }
    
    
    
}
