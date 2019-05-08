//
//  ViewController.swift
//  XibCustomPin
//
//  Created by Yusuf ali cezik on 9.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClicked(_ sender: Any) {
        
        let view = Bundle.main.loadNibNamed("CustomXib", owner: self, options: nil)?.first as! CustomXib
        
        view.layer.cornerRadius = 10
        view.frame = CGRect(x: (self.view.frame.width / 2) - view.frame.width / 2, y: (self.view.frame.height / 2) - view.frame.height / 2, width: view.frame.width, height: view.frame.height)
        
        view.onerConfig(onerilecekKonum: "ekrana tiklandi, bu konum onerilecek")
        self.view.addSubview(view)
        
        
        /* ya da aşağıdaki extension ı kullanarak ;
        let customXib = CustomXib()
        let view: UIView = (customXib.loadNib() as UIView?)!
        view.layer.cornerRadius = 10
        view.frame = CGRect(x: (self.view.frame.width / 2) - view.frame.width / 2, y: (self.view.frame.height / 2) - view.frame.height / 2, width: view.frame.width, height: view.frame.height)
        
        var vv = view as! CustomXib
        vv.onerConfig(onerilecekKonum: "asd")
        self.view.addSubview(view)
         */
      

    }
    
}

extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
