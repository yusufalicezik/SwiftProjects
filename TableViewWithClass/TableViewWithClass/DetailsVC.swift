//
//  DetailsVC.swift
//  TableViewWithClass
//
//  Created by Yusuf ali cezik on 11.03.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var meslekLabel: UILabel!
    
     var familyKarakter=FamilyKarakter()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       
        nameLabel.text=familyKarakter.isim
        meslekLabel.text=familyKarakter.meslek
        
    }
    
    
    


}
