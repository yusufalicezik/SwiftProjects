//
//  FeedCell.swift
//  TabbedApp
//
//  Created by Yusuf ali cezik on 2.04.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit
import Parse

class FeedCell: UITableViewCell {

    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postAciklama: UILabel!
    @IBOutlet weak var usernameText: UILabel!
    override func awakeFromNib() { //viewdidload gibi bir metod
        super.awakeFromNib()
        uuidLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func commentClicked(_ sender: Any) {
        let commentObject=PFObject(className:"Comments")
        commentObject["from"]=PFUser.current()?.username
        commentObject["to"]=uuidLabel.text
        
        commentObject.saveInBackground { (sc, hata) in
            if hata != nil{
                print("hata")
            }else{
                print("kaydedildi")
            }
        }
    }
    
    @IBAction func likeClicked(_ sender: Any) {
        let likeObjectt=PFObject(className:"Likes")
        likeObjectt["from"]=PFUser.current()?.username
        likeObjectt["to"]=uuidLabel.text
        
        likeObjectt.saveInBackground { (sc, hata) in
            if hata != nil{
                print("hata")
            }else{
                print("kaydedildi")
            }
        }
    }
}
