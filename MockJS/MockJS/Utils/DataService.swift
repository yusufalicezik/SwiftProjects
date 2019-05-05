//
//  DataUtils.swift
//  MockJS
//
//  Created by Yusuf ali cezik on 5.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataService {
    
    static let dataService = DataService()
    
    func kullaniciGirisYap(username : String, password : String, completion : @escaping (_ kullaniciVarMi:Bool)->()){
        
        
        Alamofire.request(BASE_URL + USERS, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let json:JSON = JSON(response.result.value!)
                let varMi = self.kullaniciVarmi(json, username,password)
                if varMi {
                    completion(true)
                }else{
                    completion(false)
                }
                
            }else{
                print("hata")
            }
        }
        
    }
    func kullaniciVarmi(_ json:JSON, _ username:String, _ password:String)->Bool{
        for i in 0..<json[].count{
            if json[i]["username"].stringValue == username && json[i]["password"].stringValue == password {
                CurrentUserDefaults.currentUser.userID = json[i]["id"].stringValue
                CurrentUserDefaults.currentUser.userName = json[i]["username"].stringValue
                CurrentUserDefaults.currentUser.userImage = json[i]["profile_image"].stringValue
                return true
            }
        }
        return false
    }
    
    
    
    
}
