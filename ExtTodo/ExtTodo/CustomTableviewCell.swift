//
//  CustomTableviewCell.swift
//  ExtTodo
//
//  Created by Yusuf ali cezik on 4.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class CustomTableviewCell: UITableViewCell {

    @IBOutlet weak var taskNameLabel: UILabel!
    
    func confData(taskName:String){
        taskNameLabel.text = taskName
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
