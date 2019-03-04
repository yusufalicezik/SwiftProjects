//
//  ViewController.swift
//  Segue
//
//  Created by Yusuf ali cezik on 3.03.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var nameText: UITextField!
    
    var name=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func gecClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "fromFirstToSecond", sender: nil)
        
    }
    
    //segue olmadan önce çalışacak olan kod
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="fromFirstToSecond" {
            
            let destinationVC=segue.destination as! SecondViewController
            
            destinationVC.name=nameText.text!
        
        
            
        }
    }
    
    
    
}

