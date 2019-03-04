//
//  SecondViewController.swift
//  Segue
//
//  Created by Yusuf ali cezik on 4.03.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    var name=""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text="Name : \(name)"
    }
    

    @IBAction func geriButonClicked(_ sender: Any) {
        
        //segue yerine direkt olarak bu aktiviteyi de kapatabiliriz. Böylelikle bi önceki açılana döner
        //
        //self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "fromSecondToFirst", sender:nil)
        
    }
    

}
