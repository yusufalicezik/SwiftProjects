//
//  SecondViewController.swift
//  TabbedApp
//
//  Created by Yusuf ali cezik on 1.04.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit
import Parse

class PostEkleViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    let delegate=UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var postImage: UIImageView!
    
    
    @IBOutlet weak var postButon: UIButton!
    @IBOutlet weak var postText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        postButon.isEnabled=false
        let keyboardRecognizer=UITapGestureRecognizer(target: self, action: #selector(PostEkleViewController.klavyeyiGizle))
        self.view.addGestureRecognizer(keyboardRecognizer)
        
        postImage.isUserInteractionEnabled=true //tıklama verdik.
        let gestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(PostEkleViewController.fotografSec))
        postImage.addGestureRecognizer(gestureRecognizer)
    }

  
    
    
    @objc func fotografSec(){
        let pickerController=UIImagePickerController()
        pickerController.delegate=self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        postImage.image=info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        //info plist e izin eklemeti unutma(photo library usage)
        
        postButon.isEnabled=true
        postButon.isUserInteractionEnabled=true
    }
    
    @objc func klavyeyiGizle(){
        self.view.endEditing(true)
    }
    @IBAction func postButonClicked(_ sender: Any) {
        let alertYukleniyor = self.delegate.alertOlustur("Paylaşılıyor...","Lütfen bekleyin, bu biraz zaman alabilir")
        self.present(alertYukleniyor, animated: true, completion: nil)
        
        
        postButon.isEnabled=false
        
        let data=postImage.image?.jpegData(compressionQuality: 0.5)
        let pfImage=PFFileObject(name: "image", data: data!)
        
        
        let uuid = UUID().uuidString //swift sayesinde random uuid aldık.postta kullanmak için
        
        let object = PFObject(className: "Posts")
        object["aciklama"]=postText.text
        object["postSahibi"]=PFUser.current()?.username
        object["postuuid"]=uuid
        object["postResim"]=pfImage

        object.saveInBackground { (success, error) in
            if error != nil {
                alertYukleniyor.dismiss(animated: true, completion: nil)
                let alert = self.delegate.alertOlustur("Hata", "Post Paylaşılamadı, lütfen tekrar deneyin.")
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                //yeni post eklendiğine dair bildirim göndermek için ilk aktiviteye
                NotificationCenter.default.post(name:NSNotification.Name(rawValue: "newPost"),object:nil)
                
                //
                
                alertYukleniyor.dismiss(animated: true, completion: nil)
                self.tabBarController?.selectedIndex=0 //ilk aktiviteye at.
                //segue yapmayız çünkü tabbarda işlemlerimiz oluyor.
                
                
                //bileşemleri de temizleyelim.
                self.postImage.image=UIImage(named: "moleculelogo.png")
                self.postText.text=""
                
            }
        }
        
        
        
    }
    
}

