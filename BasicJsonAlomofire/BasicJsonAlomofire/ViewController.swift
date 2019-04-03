//
//  ViewController.swift
//  BasicJsonAlomofire
//
//  Created by Yusuf ali cezik on 14.03.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit
import Alamofire //json verilerini çekebilmek için
import AlamofireImage
import SwiftyJSON

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let BASE_URL="https://jsonplaceholder.typicode.com/photos"
    var tumFotolar=[PhotosModel]()
    var secilenItem=PhotosModel()
    
   override func viewDidLoad() {
        super.viewDidLoad()
        verileriCek()
    
    }
    
    
    func verileriCek(){
      
        /*let p=["key":123]
        Alamofire.request(BASE_URL, method: .get, parameters: p).responseJSON {
            response in if response.result.isSuccess{
                
            }
            
        }
        */
     
        
        Alamofire.request(BASE_URL ,method: .get).responseJSON {
            response in if response.result.isSuccess {
                print("basarili")
                //
                let gelenVeri:JSON=JSON(response.result.value!)
                //print(gelenVeri) //verilerimizi json olarak çektik.(hepsini string şekilde)
                self.verileriParcala(json:gelenVeri)
            }else {
                print("error \(String(describing: response.result.error))")
            }
        }
    }
    
    
    //verileri tek tek parçalayıp moedele atayıp onu da model dizisine atadım.
    func verileriParcala(json:JSON){
        for i in 0...json[].count{
        let title=json[i]["title"].stringValue
        let albumId=json[i]["albumId"].intValue
        let id=json[i]["id"].intValue
        let url=json[i]["url"].stringValue
        let thumbnailUrl=json[i]["thumbnailUrl"].stringValue
            
            let model=PhotosModel()
            model.albumId=albumId
            model.id=id
            model.thumbnailUrl=thumbnailUrl
            model.title=title
            model.url=url
           
            tumFotolar.append(model)
            
            
        }
        
        bannerTanimla()
        tableView.reloadData()
        
    }
    
    func bannerTanimla(){
        //first index en üstteki resim bu yüzden 0. indisi aldım
        Alamofire.request(tumFotolar[0].url).responseImage {
            response in
            if let image=response.result.value {
                self.imgBanner.image=image
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tumFotolar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //custom cell im
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!  ViewControllerTableViewCell
        
        let tempModel:PhotosModel
        tempModel=tumFotolar[indexPath.row]
        
        cell.label.text=tempModel.title
        Alamofire.request(tempModel.thumbnailUrl).responseImage {
            response in
            if let image=response.result.value {
                cell.myImg.image=image
            }
        }
   
        return cell
        
    }
    
    //tabloda herhangi bir item a tıklandığında;
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        secilenItem.id=tumFotolar[indexPath.row].id //secilen item ın id sini ve
        secilenItem.url=tumFotolar[indexPath.row].url //resmin url ini aldım. SecondController a göndereceğim
        //o da bu id ye göre comments in body sini getirecek.
        secilenItem.thumbnailUrl=tumFotolar[indexPath.row].thumbnailUrl
        
        secilenItem.title=tumFotolar[indexPath.row].title
        
        performSegue(withIdentifier: "goToSecondController", sender: self)
    }
    
    
    
    //SecondViewController a gitmeden önce ordaki değişkenlerin atamasını yaptım.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="goToSecondController"){
            
            let destinationVC=segue.destination as! SecondViewController

            destinationVC.id=secilenItem.id
            destinationVC.imgUrl=secilenItem.url
            destinationVC.baslik=secilenItem.title
            destinationVC.profilUrl=secilenItem.thumbnailUrl
            
        }
    }


}

