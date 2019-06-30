//
//  DetailsVC.swift
//  AnyThng
//
//  Created by Yusuf ali cezik on 28.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    var mTitle : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if let cTitle = mTitle{
            self.navigationController?.navigationBar.prefersLargeTitles = false
            self.navigationController?.navigationBar.topItem?.title = cTitle
        }
    }
    

    

}
