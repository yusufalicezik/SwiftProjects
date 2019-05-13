//
//  ThoughtCell.swift
//  RNDM
//
//  Created by Yusuf ali cezik on 11.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import Firebase

class ThoughtCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var thoughtTxtLabel: UILabel!
    @IBOutlet weak var likesNumberLabel: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    
    
    private var thought : Thought!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTabbed))
        likesImage.addGestureRecognizer(tap)
        likesImage.isUserInteractionEnabled = true
        
    }
    
    @objc func likeTabbed(){
        Firestore.firestore().document("thoughts/\(thought.documentID)")
        .updateData([NUM_LIKES : thought.numLikes + 1])
    }

    func configureCell(thought : Thought){
        self.thought = thought
        usernameLabel.text = thought.username
        //timestampLabel.text = String(thought.timestamp)
        thoughtTxtLabel.text = thought.thoughtTxt
        likesLabel.text = String(thought.numLikes)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM d, hh:mm"
        let timeStamp = formatter.string(from: thought.timestamp)
        timestampLabel.text = timeStamp
        
    
    }
    
    
   

}
