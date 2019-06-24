//
//  AddNewVC.swift
//  CoreDataMovie
//
//  Created by Yusuf ali cezik on 23.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import CoreData

class AddNewVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var filmNameLabel: UITextField!
    @IBOutlet weak var heightCost: NSLayoutConstraint!
    @IBOutlet weak var pickerView: UIPickerView!
    var selectedCategory:String?
    @IBOutlet weak var posterImageView: UIImageView!
    var pickerItems = [String]()
    var acikMi=false
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        heightCost.constant = 0.0
        pickerItems = ["Aksiyon","Komedi","Korku","Gerilim","Bilim Kurgu","Gençlik"]
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(kapat))
        self.view.addGestureRecognizer(recognizer)
        // Do any additional setup after loading the view.
    }
    
    @objc func kapat(){
        self.view.endEditing(true)
    }
   
    @IBAction func selectCategoryClicked(_ sender: Any) {
        if acikMi{
            pickerView.isHidden = true
            heightCost.constant = 0.0
            acikMi = false
        }else{
            pickerView.isHidden = false
            heightCost.constant = 150.0
            acikMi = true
        }
        UIView.animate(withDuration: 0.7) {
          self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func selectPosterClicked(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        posterImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil) //picker ı kapattık.
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        guard let mFilmName = filmNameLabel.text else{
            return
        }
        guard let mSelectedCategory = selectedCategory else {
            return
        }
        //resim alma islemleri..
        guard let mData = posterImageView.image?.jpegData(compressionQuality: 0.5) else {
            return
        }
        
        
        
        let entity = NSEntityDescription.insertNewObject(forEntityName: "MovieX", into: context!)
        entity.setValue(mSelectedCategory, forKey: "category")
        entity.setValue(mFilmName, forKey: "name")
        entity.setValue(mData, forKey: "image")
        
        do{
            try context?.save()
            print("kayit basarili")
            self.dismiss(animated: true, completion: nil)

        }catch{
            print("error")
        }
        
        
        
    }
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension AddNewVC : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerItems.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = pickerItems[row] as String
    }
    
    
}
