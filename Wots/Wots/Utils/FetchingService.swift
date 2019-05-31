//
//  FetchingService.swift
//  Wots
//
//  Created by Yusuf ali cezik on 30.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


class FethcingService {
    static let service = FethcingService()
    
    var bulunanKullanicilar = [User]()
    
    func kullaniciAra(_ basKelime:String, completion : @escaping (_ bitti:Bool)->() ){
        bulunanKullanicilar.removeAll()
        Alamofire.request(BASE_URL + USERS, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let json:JSON = JSON(response.result.value!)
                self.kullaniciFiltrele(json, basKelime)
                completion(true)
                
            }else{
                print("hata")
            }
        }
        
        
    }
    
    func kullaniciFiltrele(_ json:JSON, _ basKelime:String){
        
       
        
        for i in 0..<json[].count{
            if json[i]["name_surname"].stringValue.contains(basKelime.ilkHarfBuyut()){
                let id = json[i]["id"].stringValue
                let username = json[i]["username"].stringValue
                let password = json[i]["password"].stringValue
                let profile_image = json[i]["profile_image"].stringValue
                let name_surname = json[i]["name_surname"].stringValue
                let email = json[i]["email"].stringValue
                
                bulunanKullanicilar.append(User(id:id, username: username, password: password, email: email, name_surname: name_surname, profile_image: profile_image))
            }
            
        }
        
    }
}
extension String {
    func ilkHarfBuyut() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func ilkHarfBuyut() {
        self = self.ilkHarfBuyut()
    }
}
