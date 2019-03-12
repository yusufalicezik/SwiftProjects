//
//  ViewController.swift
//  Database
//
//  Created by Yusuf ali cezik on 12.03.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
   
   
    @IBOutlet weak var tableView: UITableView!
    
    var diziIsimler=[String]()
    var diziArtist=[String]()
    var diziYil=[Int]()
    var diziImges=[UIImage]()
    
    
    var secilenPainting=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate=self
        tableView.dataSource=self
        
        verileriCek()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {//aktive her açıldığında çağırılır.
        //diğerinden gelen notification ı konrol ederiz.
        //yani diğer aktivitede veritabanına veri eklendiğinde bildirim gönderilir ve o bildirime göre verileri listeden silip tekrar veritabanından çekeriz. liste temizlenir ve en son güncel veriler çekilir.
        //bu şöyle de yapılabilirdi ; veriler eklenir veritabanına ama v.tabanından tekrar çekmek yerine listeye eklerdik, tabloyu reload yapardık ve değişiklikler gözükürdü. kapatıp açınca da zaten v.tabanından çektiği için sorun olmazdı.
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.verileriCek), name: NSNotification.Name(rawValue: "newPainting"), object: nil)
    }

    @IBAction func yeniEkleButonClick(_ sender: Any) {
        secilenPainting=""
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diziIsimler.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        cell.textLabel?.text=diziIsimler[indexPath.row]
        return cell
    }
    
   @objc func verileriCek(){
        diziIsimler.removeAll(keepingCapacity: false)
        diziYil.removeAll(keepingCapacity: false)
        diziImges.removeAll(keepingCapacity: false)
        diziArtist.removeAll(keepingCapacity: false)
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        
        //bu kez context.save yerine fetch kullanacağız.
        //CoreData import et!
        
        let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false //verilerimizi artık tek tek çekip
        //diziler içine çekebileceğimiz bi istek yarattık.
        
        do{
             let results = try context.fetch(fetchRequest)//bu results bana bir dizi verir.
            
            if(results.count>0){
                for result in results as! [NSManagedObject]{ //NS olarak almamın sebebi aynı coredata modelinde kullanabilmek.
                    
                    if let gelenName = result.value(forKey: "name") as? String{
                        self.diziIsimler.append(gelenName)
                    } //name olarak kaydedilmiş ne varsa onu verir.(olmama olasılığı var if let)
                    
                    if let gelenArtist = result.value(forKey: "artist") as? String{
                        self.diziArtist.append(gelenArtist)
                    }
                    
                    if let gelenYil = result.value(forKey: "year") as? Int{
                        self.diziYil.append(gelenYil)
                    }
                    
                    if let gelenImageData = result.value(forKey: "image") as? Data{ //resim farklı
                        let image=UIImage(data:gelenImageData)
                        self.diziImges.append(image!)
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }
            }
            
        }catch{
            print("hata")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        secilenPainting=diziIsimler[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="toDetailsVC"{
            let destinationVC=segue.destination as! DetailsVC
            
            destinationVC.gelenIsim=secilenPainting
            
        }
    }
    
    
    //silerken, sildiğim indexteki veriyi alıyorum.(dizi[i]) ile. daha sonra o isme sahip olan veriyi v.tabanından bulup siliyorum ki table dan silinen ordan da silinsin. ayrıca dizimden o silinen i çıkarıyorum ve tabloyu yeniden refresh ediyorum. en son save diyerek kaydediyorum yaptıklarımı
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate=UIApplication.shared.delegate as! AppDelegate
            let context=appDelegate.persistentContainer.viewContext
            let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")

            do {
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject]{
                    if let name=result.value(forKey: "name") as? String {
                        if(name==diziIsimler[indexPath.row]){ //tablodan sildiğim isim v.tabanında varsa vtabanından da sil
                            context.delete(result) //şuan içinde bulunduğum result olan nsobject i sil.
                            //satır gibi yani, bu satırı komple sil.
                            diziIsimler.remove(at: indexPath.row)
                            diziImges.remove(at: indexPath.row)
                            diziYil.remove(at: indexPath.row)
                            diziArtist.remove(at: indexPath.row)
                            self.tableView.reloadData()
                            
                            /*
 tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade) bunu yapmak yerine
                             sildiğimizi düşündüğümüz index teki veriyi dizi[i] yaparak diziden çıkardık
                             sonra reload yaptık tabloya
                            */
                            do{
                                try context.save()
                                
                            }catch{
                                
                            }
                            break //bulup sildikten sonra for u kır.
                            
                            
                        }
                    }
                }
            }catch{
                
            }
            
        }
    }
}

