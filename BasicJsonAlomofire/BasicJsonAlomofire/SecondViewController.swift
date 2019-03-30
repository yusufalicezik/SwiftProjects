//
//  SecondViewController.swift
//  BasicJsonAlomofire
//
//  Created by Yusuf ali cezik on 14.03.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class SecondViewController: UIViewController {
    @IBOutlet weak var labelBody: UILabel!
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelMail: UILabel!
    @IBOutlet weak var imgProfil: UIImageView!
    
    var id:Int=0 //first Controller dan gelen id
    var imgUrl:String="" //gelen resim url
    var profilUrl:String=""
    var baslik:String=""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilBilgileriTanimla()
        bannerTanimla() //gelen url e göre üstteki resmi tanımla
        verileriCek() //gelen id ye göre json verilerini çek
    }
    

    func verileriCek(){
        //id parametresi request isteği yapılırken ayrı bir paramtre olarak verilebilirdi ama ben direkt olarak url in sonuna ekledim
         let BASE_URL="https://jsonplaceholder.typicode.com/comments?id="+String(self.id)
        Alamofire.request(BASE_URL, method: .get).responseJSON {
            response in if response.result.isSuccess {
                print("basarili")
                //
                let gelenVeri:JSON=JSON(response.result.value!)
                //print(gelenVeri) //verilerimizi json olarak çektik.(hepsini string şekilde)
                self.verileriParcala(json:gelenVeri)
                //
                
                
            }else {
                print("error \(String(describing: response.result.error))")
            }
        }
    }
    
   
    //gelen id ye sahip olan json verisinden istediğim alanları çektim ;
    func verileriParcala(json:JSON){
        //eğer o id ye sahip bir veri var ise onu al(sadece 0 dememin sebebi her id bir json verisi ile eşleşiyor)
        if json[].count>0{
            let body=json[0]["body"].stringValue
            labelBody.text=body
            
            let mail=json[0]["email"].stringValue
            labelMail.text=mail
            
        }
            
      
        
    }
    
    func bannerTanimla(){
        //first index üstteki resim/banner
        Alamofire.request(imgUrl).responseImage {
            response in
            if let image=response.result.value {
                self.imgBanner.image=image
            }
        }
    }
    
    func profilBilgileriTanimla(){
        
        imgProfil.layer.borderWidth = 1
        imgProfil.layer.masksToBounds = false
        imgProfil.layer.borderColor = UIColor.black.cgColor
        imgProfil.layer.cornerRadius = imgProfil.frame.width/2
        imgProfil.clipsToBounds = true
        
        Alamofire.request(profilUrl).responseImage {
            response in
            if let image=response.result.value {
                self.imgProfil.image=image
            }
        }
        
        labelTitle.text=baslik
        
        
    }

}
