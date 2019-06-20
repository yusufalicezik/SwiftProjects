//
//  SecondVCViewController.swift
//  ExercsPrj
//
//  Created by Yusuf ali cezik on 20.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SecondVC: UIViewController {

    var selectedPhoto:Photo!
    var downloadTask = DownloadTasks()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
  
    @IBOutlet weak var sharedFromLabel: UILabel!
    
    
    @IBOutlet weak var postBodyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedPhoto != nil {
            configViewsAndDownloadData()
        }else{
            self.dismiss(animated: true, completion: nil)
        }

        
    }
    
    func configViewsAndDownloadData(){
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        downloadTask.mDelegateSecondVc = self
        downloadTask.dataDownload(2, paramsId: selectedPhoto.albumId!) { (bitti) in
            if bitti{
                
            }else{
                
            }
        }
        Alamofire.request(selectedPhoto.url!).responseImage {
            response in
            if let image=response.result.value {
                self.bannerImage.image = image
            }
        }
        titleLabel.text = selectedPhoto.title!
        
        
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
extension SecondVC : DataDelegateSecondVc {
    func getSecondVCDataList(comment: Comment) {
        if comment.body != nil {
            postBodyLabel.text = comment.body!
            sharedFromLabel.text = comment.email!
            Alamofire.request(selectedPhoto.thumbnailUrl!).responseImage {
                response in
                if let image=response.result.value {
                    self.profileImage.image = image
                }
            }
        }
    }
    
    
    
   
   
    
    
}
