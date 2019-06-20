//
//  TableViewCell.swift
//  ExercsPrj
//
//  Created by Yusuf ali cezik on 18.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var pLabel: UILabel!
    @IBOutlet weak var pImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configureMyCell(photo:Photo){
        if let mTitle = photo.title{
            pLabel.text = mTitle
        }
        if let mPhoto = photo.thumbnailUrl {
            Alamofire.request(mPhoto).responseImage {
                response in
                if let image=response.result.value {
                    self.pImage.image = image
                }
            }
        }
        
    }

    

}
