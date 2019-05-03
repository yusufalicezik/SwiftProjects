//
//  PopVC.swift
//  MapCity
//
//  Created by Yusuf ali cezik on 3.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class PopVC: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var popImageView: UIImageView!
    
    var passedImage:UIImage?
    
    func initData(image:UIImage){
            self.passedImage=image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popImageView.image = passedImage
        addDoubleTap()
       
    }
    
    func addDoubleTap(){
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(closePopUpVC))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        self.view.addGestureRecognizer(doubleTap)
    }
    @objc func closePopUpVC(){
        dismiss(animated: true, completion: nil)
    }

   

}
