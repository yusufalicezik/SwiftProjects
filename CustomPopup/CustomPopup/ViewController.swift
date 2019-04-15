//
//  ViewController.swift
//  CustomPopup
//
//  Created by Yusuf ali cezik on 15.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var secilenTarihLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // let sb = UIStoryboard(name: "CustomPopupStoryboard", bundle: nil)
    /*    let vc = self.storyboard?.instantiateViewController(withIdentifier:"secondVC") as! SecondViewController
      vc.delegate = self
 */
    
    }

    

    @IBAction func tarihSecClicked(_ sender: Any) {
       performSegue(withIdentifier: "mySegue", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass the selected object to the new view controller.
        if segue.identifier == "mySegue" {
            let vc : CustomPopupViewController = segue.destination as! CustomPopupViewController
            vc.popupDelegate = self
        }
    }
    
}

extension ViewController : PopupDataDelegate{
    func tarihSec(secilenTarih: String) {
        secilenTarihLabel.text = secilenTarih
        print("seçildi :D")
    }
    
    
}
