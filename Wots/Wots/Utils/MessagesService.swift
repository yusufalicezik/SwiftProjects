//
//  MessagesService.swift
//  Wots
//
//  Created by Yusuf ali cezik on 30.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessagesService {
    static let service = MessagesService()
    
    func kullaniciylaMesajlariCek(from : String, to : String){
        
    }
    func kullaniciylaMesajlariKaydet(mesaj:Mesaj){
        let params = ["ow":mesaj.ow!, "to":mesaj.to!, "text":mesaj.text!,
                      "owner":mesaj.owner!] 
        Alamofire.request(BASE_URL+MESSAGES, method: .post, parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                print("ekleme basarili")
                
            }else{
               
            }
        }
    }
}
