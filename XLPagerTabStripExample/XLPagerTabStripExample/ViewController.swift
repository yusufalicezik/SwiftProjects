//
//  ViewController.swift
//  XLPagerTabStripExample
//
//  Created by Yusuf ali cezik on 4.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ViewController: ButtonBarPagerTabStripViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.3407950997, green: 0.4556471705, blue: 0.4991626143, alpha: 1)
        loadDesign()
        let height = UIApplication.shared.statusBarFrame.height +
            self.navigationController!.navigationBar.frame.height
        buttonBarView.frame.origin.y = buttonBarView.frame.origin.y + height
       
        
       // self.containerView.bounces = false
    }
    
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Child1VC")
        let child2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Child2VC")
        let child3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Child3VC")
       
        let child4 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChildExVC")
        return [child1,child2,child3,child4]
    }
    
    
    func loadDesign(){
        
     
        self.settings.style.selectedBarBackgroundColor = .clear
        self.settings.style.buttonBarItemLeftRightMargin = 0
        self.settings.style.buttonBarItemBackgroundColor = .clear
        self.settings.style.buttonBarMinimumInteritemSpacing = 0
        self.settings.style.buttonBarItemsShouldFillAvailableWidth = true
        self.settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        self.settings.style.buttonBarLeftContentInset  = 0
        self.settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        self.settings.style.buttonBarMinimumLineSpacing = 0
        buttonBarView.backgroundColor = #colorLiteral(red: 0.3407950997, green: 0.4556471705, blue: 0.4991626143, alpha: 1)
        buttonBarView.selectedBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            if let baslik = newCell?.label.text {
                self.navigationController?.navigationBar.topItem?.title = baslik
                print(baslik)
            }
            
            oldCell?.label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            newCell?.label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
       
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func buttonClicked(_ sender: Any) {
        moveToViewController(at: 3)
    }
    
    
}

