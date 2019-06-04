//
//  Child1VC.swift
//  XLPagerTabStripExample
//
//  Created by Yusuf ali cezik on 4.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Child1VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension Child1VC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Anasayfa")
    }
}
