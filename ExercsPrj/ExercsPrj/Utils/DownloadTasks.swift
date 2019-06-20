//
//  DownloadTasks.swift
//  ExercsPrj
//
//  Created by Yusuf ali cezik on 18.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DownloadTasks{

    var mDelegate:DataDelegate?
    var mDelegateSecondVc:DataDelegateSecondVc?
 
    func dataDownload(_ vcType: Int,paramsId:Int,completion : @escaping (_ bitti:Bool)->()){
        if vcType == 1 {
            Alamofire.request(BASE_URL+PHOTOS ,method: .get).responseJSON {
                response in if response.result.isSuccess {
                    print("basarili")
                    //
                    let gelenVeri:JSON=JSON(response.result.value!)
                    
                    self.serializationData(json: gelenVeri, vcType: vcType, jsonComp: { (jsonBitti) in
                        if jsonBitti{
                            print("ikinci bitiyor")
                            completion(true)
                        }
                    })
                    }else {
                    print("error \(String(describing: response.result.error))")
                }
            }
        }else{
            let params = ["id" : paramsId]
            Alamofire.request(BASE_URL+COMMENTS ,method: .get, parameters: params).responseJSON {
                response in if response.result.isSuccess {
                    print("basarili")
                    //
                    let gelenVeri:JSON=JSON(response.result.value!)
                    
                    self.serializationData(json: gelenVeri, vcType: vcType, jsonComp: { (jsonBitti) in
                        if jsonBitti{
                            print("ikinci bitiyor")
                            completion(true)
                        }
                    })
                }else {
                    print("error \(String(describing: response.result.error))")
                }
            }
        }
        
    }
    func serializationData(json:JSON, vcType:Int, jsonComp : @escaping(_ jsonBitti:Bool)->()){
        if vcType == 1 {
            
            var photos = [Photo]()
            for i in 0..<json[].count-1{
                let photo = Photo()
                photo.albumId = json[i]["id"].intValue
                photo.title = json[i]["title"].stringValue
                photo.thumbnailUrl = json[i]["thumbnailUrl"].stringValue
                photo.url = json[i]["url"].stringValue
                
                photos.append(photo)
            }
//            let firstVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstVC") as? FirstVC
//            firstVc!.denemeYazdir(pp:photos)
                mDelegate?.getFirstVCDataList(list: photos)
                print("ilk bitiyor.")
                jsonComp(true)
        }else{ //2. vc den çağırmışsam isteği
            let comment = Comment()
            if json[].count > 0 {
                comment.body = json[0]["body"].stringValue
                comment.email = json[0]["email"].stringValue
                comment.name = json[0]["name"].stringValue
                mDelegateSecondVc?.getSecondVCDataList(comment : comment)
            }
            
        }
            
            
    }
    
}

