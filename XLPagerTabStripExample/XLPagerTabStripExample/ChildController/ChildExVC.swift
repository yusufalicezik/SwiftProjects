//
//  ChildExVC.swift
//  XLPagerTabStripExample
//
//  Created by Yusuf ali cezik on 4.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ChildExVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}
extension ChildExVC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Paylaş")
    }
}
