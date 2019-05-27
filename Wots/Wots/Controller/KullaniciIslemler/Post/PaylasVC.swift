//
//  PaylasVC.swift
//  Wots
//
//  Created by Yusuf ali cezik on 24.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import AlamofireImage


class PaylasVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postAciklamaTextview: UITextView!
    
    //
    var imagePicker = UIImagePickerController()
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postImageView.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action:#selector(galeriAc))
        postImageView.addGestureRecognizer(recognizer)
        
    }
    @objc func galeriAc(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("qwe")
              picker.dismiss(animated: true, completion: nil)
              guard let image = info[.originalImage] as? UIImage else {
                  fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
              }
             postImageView.image = image
          }

    @IBAction func paylasButtonClicked(_ sender: Any) {
        SVProgressHUD.show()
        guard let postImage = postImageView.image else { SVProgressHUD.dismiss(); return }
        if postAciklamaTextview.text != nil {
            var post = Post()
            SVProgressHUD.dismiss()
            let imgData = postImage.jpegData(compressionQuality: 0.5)
            
            let params = ["postedFrom" : "yusuf"]
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData!, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpg")
                for (key, value) in params {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                } //Optional for extra parameters
            },
                             to:BASE_URL+POSTS)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        print(response.result.value)
                    }
                    
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
           
            
        }else{
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Hata", message: "Lütfen bir açıklama girin", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}
