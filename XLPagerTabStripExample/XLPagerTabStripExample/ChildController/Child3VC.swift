//
//  Child3VC.swift
//  XLPagerTabStripExample
//
//  Created by Yusuf ali cezik on 4.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Child3VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

   

}
extension Child3VC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Paylaş")
    }
}
