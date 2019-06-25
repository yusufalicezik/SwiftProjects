//
//  ViewController.swift
//  ExercsPrj
//
//  Created by Yusuf ali cezik on 18.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FirstVC: UIViewController {
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
     var allPhotos = [Photo]()
    var pp2 = [Photo]()
    let downloadTask = DownloadTasks() //farklı nesneler olmaması için bu şekilde yaptım. delegate tanımlanan ile dataDownload eden nesnelerin aynı olması açısından.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        downloadTask.mDelegate = self
        //configViews()
        
        downloadData()
        
    }
    
    func configViews(){
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(deleteRow(_:)))
        recognizer.direction = .right
        tableView.addGestureRecognizer(recognizer)
    }
    @objc func deleteRow(_ gesture:UISwipeGestureRecognizer){
        print("kaydi..")
    }
    
    func configComp(){
        Alamofire.request(allPhotos[0].url!).responseImage {
            response in
            if let image=response.result.value {
                self.bannerImage.image = image
            }
        }
    }
    
    func downloadData(){
        downloadTask.dataDownload(1, paramsId:-1) { (bitti) in
            if bitti {
                
                
            }else{
                print("devam ediyor..")
            }
            
            
        }
    }
    
   


}
extension FirstVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.configureMyCell(photo: allPhotos[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let secondVc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as? SecondVC{
            secondVc.selectedPhoto = allPhotos[indexPath.row]
            self.present(secondVc, animated: true, completion: nil)
        }
    }
    
    
    
    
}

//DataDownload
extension FirstVC : DataDelegate{
    func getFirstVCDataList(list: [Photo]) {
        allPhotos = list
        self.tableView.reloadData()
        configComp()
    }
    
    
}
