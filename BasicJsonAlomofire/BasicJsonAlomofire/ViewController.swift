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
    var tumPhotos=[PhotosModel]()
    var pics=[UIImage]()
    var secilenItem=PhotosModel()
    
   override func viewDidLoad() {
        super.viewDidLoad()
        verileriCek()
    }
    
    
    func verileriCek(){
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
           
            tumPhotos.append(model)
            
            
        }
        
        bannerTanimla()
        
        tableView.reloadData()
        
        
        
       
        
        
    }
    
    func bannerTanimla(){
        //first index banner
        Alamofire.request(tumPhotos[0].url).responseImage {
            response in
            if let image=response.result.value {
                self.imgBanner.image=image
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tumPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let tempModel:PhotosModel
        tempModel=tumPhotos[indexPath.row]
        
        cell.label.text=tempModel.title
        Alamofire.request(tempModel.thumbnailUrl).responseImage {
            response in
            if let image=response.result.value {
                cell.myImg.image=image
            }
        }
   
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        secilenItem.id=tumPhotos[indexPath.row].id
        secilenItem.url=tumPhotos[indexPath.row].url
        performSegue(withIdentifier: "goToSecondController", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="goToSecondController"){
            
            let destinationVC=segue.destination as! SecondViewController

            destinationVC.id=secilenItem.id
            destinationVC.imgUrl=secilenItem.url
            
        }
    }


}

