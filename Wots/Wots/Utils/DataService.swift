
//
//  Created by Yusuf ali cezik on 17.05.2019.
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
                CurrentUserDefaults.currentUser.user.id = json[i]["id"].stringValue
                CurrentUserDefaults.currentUser.user.username = json[i]["username"].stringValue
                CurrentUserDefaults.currentUser.user.profile_image = json[i]["profile_image"].stringValue
                CurrentUserDefaults.currentUser.user.email = json[i]["email"].stringValue
                CurrentUserDefaults.currentUser.user.name_surname = json[i]["name_surname"].stringValue
                CurrentUserDefaults.currentUser.user.password = password
                girisYapanKaydet()
                return true
            }
        }
        return false
    }
    
    
    func kullaniciKaydiYap(user:User, completion : @escaping (_ bitti:Bool)->()){
        let params = ["username":user.username!, "password":user.password!, "profile_image":user.profile_image!,
                      "email":user.email!, "name_surname":user.name_surname!]
        Alamofire.request(BASE_URL+USERS, method: .post, parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                print("ekleme basarili")
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    
    func girisYapanKaydet(){
        UserDefaults.standard.set(CurrentUserDefaults.currentUser.user.username!, forKey: "username")
        UserDefaults.standard.set(CurrentUserDefaults.currentUser.user.password!, forKey: "password")
        UserDefaults.standard.set(CurrentUserDefaults.currentUser.user.email!, forKey: "email")
        UserDefaults.standard.set(CurrentUserDefaults.currentUser.user.name_surname!, forKey: "name_surname")
        UserDefaults.standard.set(CurrentUserDefaults.currentUser.user.profile_image!, forKey: "profile_image")
        UserDefaults.standard.set(CurrentUserDefaults.currentUser.user.id!, forKey: "id")
    }
    
    //kullanılmıyor.
    func girisYapanGetir()->User{
        let user = User()
        user.username = UserDefaults.standard.string(forKey: "username") ?? "Null"
        user.password = UserDefaults.standard.string(forKey: "password") ?? "Null"
        user.email = UserDefaults.standard.string(forKey: "email") ?? "Null"
        user.name_surname = UserDefaults.standard.string(forKey: "name_surname") ?? "Null"
        user.profile_image = UserDefaults.standard.string(forKey: "profile_image") ?? "Null"
        user.id = UserDefaults.standard.string(forKey: "id") ?? "Null"
        
        return user
    }
    
    func cikisYap(){
        
        CurrentUserDefaults.currentUser.user.id = "Null"
        CurrentUserDefaults.currentUser.user.username = "Null"
        CurrentUserDefaults.currentUser.user.profile_image = "Null"
        CurrentUserDefaults.currentUser.user.email = "Null"
        CurrentUserDefaults.currentUser.user.name_surname = "Null"
        CurrentUserDefaults.currentUser.user.password = "Null"
        
        UserDefaults.standard.set(CurrentUserDefaults.currentUser.user.username!, forKey: "username")
        UserDefaults.standard.set(CurrentUserDefaults.currentUser.user.password!, forKey: "password")
        UserDefaults.standard.set(CurrentUserDefaults.currentUser.user.email!, forKey: "email")
        UserDefaults.standard.set(CurrentUserDefaults.currentUser.user.name_surname!, forKey: "name_surname")
        UserDefaults.standard.set(CurrentUserDefaults.currentUser.user.profile_image!, forKey: "profile_image")
        UserDefaults.standard.set(CurrentUserDefaults.currentUser.user.id!, forKey: "id")
    }
    
    //Bu method appDelegate den çağırılır, veritabanına kaydedilen en son kullanıcı bilgileri, kullanıcı uygulamayı kapatıp açtığında da kalsın diye CurrentUserDefaults a tanımlamalar yapılır.
    func CurrentUserTanimla(user:User){
        CurrentUserDefaults.currentUser.user.id = user.id!
        CurrentUserDefaults.currentUser.user.username = user.username!
        CurrentUserDefaults.currentUser.user.profile_image = user.profile_image!
        CurrentUserDefaults.currentUser.user.email = user.email!
        CurrentUserDefaults.currentUser.user.name_surname = user.name_surname!
        CurrentUserDefaults.currentUser.user.password = user.password!
    }
    
    
    
    
    
}
