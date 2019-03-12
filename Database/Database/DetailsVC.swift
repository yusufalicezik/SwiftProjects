//
//  DetailsVC.swift
//  Database
//
//  Created by Yusuf ali cezik on 12.03.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit
import CoreData

class DetailsVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTabloAdi: UITextField!
    @IBOutlet weak var labelArtistAdi: UITextField!
    @IBOutlet weak var labelYil: UITextField!
    
    
    var gelenIsim:String=""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if gelenIsim != ""{ //gelen verim null değilse buna göre diğer verileri çek. name i kullanarak filtlere
            let appDelegate=UIApplication.shared.delegate as! AppDelegate
            let context=appDelegate.persistentContainer.viewContext
            
            //bu kez context.save yerine fetch kullanacağız.
            //CoreData import et!
            
            let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            //filtreleme yapmak için;
            //name in eşit olduğu yerleri bul;
            fetchRequest.predicate=NSPredicate(format: "name=%@",self.gelenIsim) //name in gelen isme için olanı bul
            fetchRequest.returnsObjectsAsFaults = false //verilerimizi artık tek tek çekip
            
            do{
                let results=try context.fetch(fetchRequest)
                
                if results.count>0{
                    for result in results as! [NSManagedObject]{
                        if let artist=result.value(forKey: "artist") as? String{
                            labelArtistAdi.text=artist
                        }
                        if let name=result.value(forKey: "name") as? String{
                            labelTabloAdi.text=name
                        }
                        if let year=result.value(forKey: "year") as? Int{
                            labelYil.text=String(year)
                        }
                        if let data=result.value(forKey: "image") as? Data{
                            let image=UIImage(data: data)
                            imageView.image=image
                        }
                    }
                }
            }catch{
                
            }
            
        }
        

        imageView.isUserInteractionEnabled = true
        let gesture=UITapGestureRecognizer(target: self, action: #selector(DetailsVC.resimSec))
        imageView.addGestureRecognizer(gesture)
        
        tiklananVerileriTanimla()
    }
    
    func tiklananVerileriTanimla(){
        labelTabloAdi.text=gelenIsim
    }
    
    
    @objc func resimSec(){ //resim seç tıklandığında yapılacaklar
        
        let picker=UIImagePickerController()
        picker.delegate=self
        picker.sourceType = .photoLibrary //veriler nerden gelecek?
        picker.allowsEditing=true
        present(picker,animated: true,completion: nil) //comp:bittiğinde ne olacak?
        
    }
    
    //resimi seçtikten sonra ne olcak?
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image=info[.originalImage] as? UIImage //seçilen resmi imageview ıma ata(info any olarak dödüğü için as! ekleyip cast ettik)
        
        self.dismiss(animated: true, completion: nil) //present edilen picker ı kapat
        //info.plist e gidip izin ver.
    }

    @IBAction func kaydetButtonClick(_ sender: Any) {
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate //appdelegate ı değişkenmiş gibi çağırdık.
        let context=appDelegate.persistentContainer.viewContext //context e erişim
        //bu context i kullanarak kayıt işlemlerini yapacağız.
        //context.save() vs..
        
        
        //import coredata dememiz lazım;
        let yeniObje=NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        //yeni oluşturduğumuz entitiy i çağırdık.(paintings in içine kaydet, context i kullanark)
        
        //daha sonra yeniobjemin özelliklerini set edebilirim.
        yeniObje.setValue(labelArtistAdi.text, forKey: "artist")
        yeniObje.setValue(labelTabloAdi.text, forKey: "name")
        
        if let year=Int(labelYil.text!){
            //buraya sözel de yazabilir. o yüzden kontrol ettim
              yeniObje.setValue(year, forKey: "year")
            }
        
        let data=imageView.image?.jpegData(compressionQuality: 0.50) //boyutu yarısına indirdik
        yeniObje.setValue(data, forKey: "image")
        
        
        do {
         try context.save()
            print("no error")
        }catch{
            print("error")
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPainting"), object: nil)//yeni eklendi bildirimi yolladım. diğer aktivitede bunu kontrol ederiz.
        self.navigationController?.popViewController(animated: true) //bu nav. controller ı kullanarak
        //bi önceki activity ye geri dön demek.
        
    }
    

}
