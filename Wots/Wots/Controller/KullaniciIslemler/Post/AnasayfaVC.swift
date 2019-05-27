//
//  AnasayfaVC.swift
//  Wots
//
//  Created by Yusuf ali cezik on 18.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class AnasayfaVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var postArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        downloadPosts { (bittiMi) in
            if bittiMi{
                self.tableView.reloadData()
            }
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print(CurrentUserDefaults.currentUser.user.name_surname!)
    }
    

   

}
extension AnasayfaVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostCell else { return  UITableViewCell()}
        //cell.postDateLabel.text = String(postArray[indexPath.row].postDate!)
        
        cell.postDescriptionLabel.text = postArray[indexPath.row].postDescription!
        cell.nameSurnameLabel.text = postArray[indexPath.row].postedFrom!
        
        Alamofire.request(postArray[indexPath.row].postImage!).responseImage {
            response in
            if let image=response.result.value {
                cell.postImageView.image = image
            }
        }
        Alamofire.request(postArray[indexPath.row].postedFromImage!).responseImage {
            response in
            if let image=response.result.value {
                cell.profileImageView.image = image
            }
        }
        
        return cell
    }
    
    
}

extension AnasayfaVC {
    func downloadPosts(completion : @escaping (_ basarili:Bool)->()){
        
        Alamofire.request(BASE_URL + POSTS, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let json:JSON = JSON(response.result.value!)
                self.verileriParcala(json)
                completion(true)
            }else{
                print("hata")
            }
        }
        
    }
    
    
    func verileriParcala(_ json:JSON){
        for i in 0..<json[].count{
            let id = json[i]["id"].stringValue
            let postImage = json[i]["postImage"].stringValue
            let postedFrom = json[i]["postedFrom"].stringValue
            let postDescription = json[i]["postDescription"].stringValue
            let postedFromImage = json[i]["postedFromImage"].stringValue
            let postDate = Date(timeIntervalSince1970: TimeInterval(json[i]["id"].intValue))
            let postLikeCount = json[i]["postLikeCount"].intValue
            
            let post = Post(id: id, postImage: postImage, postedFrom: postedFrom, postDate: postDate, postLikeCount: postLikeCount, postDescription: postDescription, postedFromImage: postedFromImage)
            postArray.append(post)
            
        }
    }
}
