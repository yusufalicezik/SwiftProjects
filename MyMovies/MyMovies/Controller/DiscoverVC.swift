//
//  DiscoverVC.swift
//  MyMovies
//
//  Created by Yusuf ali cezik on 5.04.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class DiscoverVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
  
    
    //https://api.themoviedb.org/3/genre/movie/list?api_key=ae32fbb3535e8e640aff557640da5021&language=en-US
    let BASE_URL="https://api.themoviedb.org/3"
    let API_KEY:String="ae32fbb3535e8e640aff557640da5021"
    let LANGUAGE="tr-TR"
    let SEARCH_URL="/genre/movie/list"
    var parameters:[String:String]?
    var genreIdArray=[String]()
    var genreNameArray=[String]()
    
    

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        parameters=["api_key":API_KEY, "language":LANGUAGE]
        verileriCek()

    }
    
    func verileriCek(){
        Alamofire.request(BASE_URL+SEARCH_URL, method: .get, parameters:self.parameters).responseJSON {
            response in if response.result.isSuccess {
                print("basarili")
                
                let gelenVeri:JSON=JSON(response.result.value!)
                self.verileriParcala(json:gelenVeri)
            }else {
                print("error \(String(describing: response.result.error))")
            }
        }
    }
    
    
    func verileriParcala(json:JSON){
        genreIdArray.removeAll(keepingCapacity: false)
        genreNameArray.removeAll(keepingCapacity: false)
        if json["genres"].count>0{
            for i in 0...json["genres"].count-1{
                let id=json["genres"][i]["id"].stringValue
                let name=json["genres"][i]["name"].stringValue
                
                genreIdArray.append(id)
                genreNameArray.append(name)
                
            }
            tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DiscoverCell
        cell.categoryNameLabel.text=genreNameArray[indexPath.row]
        cell.categoryIDLabel.text=genreIdArray[indexPath.row]
       
        return cell
    }
    

   

}
