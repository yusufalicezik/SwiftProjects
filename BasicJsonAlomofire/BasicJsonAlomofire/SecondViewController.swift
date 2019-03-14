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
    
    var id:Int=0
    var imgUrl:String=""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerTanimla()
        verileriCek()
    }
    

    func verileriCek(){
         let BASE_URL="https://jsonplaceholder.typicode.com/comments?postId="+String(self.id)
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
        
        if json[].count>0{
            let body=json[0]["body"].stringValue
            labelBody.text=body }
            
      
        
    }
    
    func bannerTanimla(){
        //first index banner
        Alamofire.request(imgUrl).responseImage {
            response in
            if let image=response.result.value {
                self.imgBanner.image=image
            }
        }
    }

}
