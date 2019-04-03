//
//  TopRatedCell.swift
//  MyMovies
//
//  Created by Yusuf ali cezik on 3.04.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit

class TopRatedCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieRateLabel: UILabel!
    @IBOutlet weak var movieIDLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        movieIDLabel.isHidden=true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
