//
//  MessagesCell.swift
//  Wots
//
//  Created by Yusuf ali cezik on 30.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class MessagesCell: UITableViewCell {

    @IBOutlet weak var textFieldGelenMesaj: UILabel!
    @IBOutlet weak var textFieldGonderenMesaj: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
