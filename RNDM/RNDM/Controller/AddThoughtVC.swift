//
//  AddThoughtVC.swift
//  RNDM
//
//  Created by Yusuf ali cezik on 11.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class AddThoughtVC: UIViewController, UITextViewDelegate {

    //Outlets
    @IBOutlet weak var categorySegment: UISegmentedControl!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var thoughtText: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    
    private var selectedCategory = ThoughtCategory.eglenceli.rawValue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postButton.layer.cornerRadius = 4
        thoughtText.layer.cornerRadius = 4
        thoughtText.text = ""
        thoughtText.text = "Ne düşünüyorsun?"
        thoughtText.textColor = UIColor.lightGray
        thoughtText.delegate = self

        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    

    @IBAction func postButtonClicked(_ sender: Any) {
        guard let username = usernameTxt.text else {return}
        ProgressHUD.show()
        Firestore.firestore().collection("thoughts").addDocument(data: [
            CATEGORY : selectedCategory,
            NUM_COMMENTS : 0,
            NUM_LIKES : 0,
            THOUGHTS_TXT : thoughtText.text!,
            TIMESTAMP : FieldValue.serverTimestamp(),
            USERNAME : username
        ]) { (error) in
            if let _ = error {
                ProgressHUD.dismiss()
                debugPrint("Error")
            }else{
                ProgressHUD.dismiss()
                self.navigationController?.popViewController(animated: true) //tekrar bi önceki controller a atar.
            }
        }
    
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.eglenceli.rawValue
        case 1:
            selectedCategory = ThoughtCategory.ciddi.rawValue
        case 2:
            selectedCategory = ThoughtCategory.cilgin.rawValue
        default:
            selectedCategory = ThoughtCategory.eglenceli.rawValue
        }
    }
    
}
