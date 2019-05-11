//
//  ThoughtCell.swift
//  RNDM
//
//  Created by Yusuf ali cezik on 11.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ThoughtCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var thoughtTxtLabel: UILabel!
    @IBOutlet weak var likesNumberLabel: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(thought : Thought){
        usernameLabel.text = thought.username
        //timestampLabel.text = String(thought.timestamp)
        thoughtTxtLabel.text = thought.thoughtTxt
        likesNumberLabel.text = String(thought.numLikes)
    
    }
   

}
