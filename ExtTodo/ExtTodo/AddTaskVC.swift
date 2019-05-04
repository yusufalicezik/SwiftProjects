//
//  AddTaskVC.swift
//  ExtTodo
//
//  Created by Yusuf ali cezik on 4.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class AddTaskVC: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
        nextButton.bindKeyboard()
        
    }
    

    @IBAction func backButtonPressed(_ sender: Any) {
        dismissTaskVC() //soldan sağa kapatması için.
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        guard let listsVC = storyboard?.instantiateViewController(withIdentifier: "ListsVC") as? ListsVC else {return}
        presentAddTaskVC(listsVC)
    }
    
}
extension AddTaskVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
