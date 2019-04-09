//
//  ViewController.swift
//  LoginWithPageview
//
//  Created by Yusuf ali cezik on 8.04.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
 
   
    var titleArray=[",", "WApp Nedir?","Başlarken"]
    var messageArray=[",", "Bu app ile sosyal medyada istediğin gibi gezebilir, paylaşımlar yapabilir, beğenip yorum yapabilir ve takipçilerin ile dilediğin gibi mesajlaşabilirsin.","Başlamak için son kez kaydır ve wApp'e kayıt ol."]
    
    
    var tempArray=["Emre Yaman", "Rıdvan Kabak", "Yusuf Ali Çezik", "Can Yardımcı", "Hasan Cerit"]
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate=self
        collectionView.dataSource=self
        pageControl.numberOfPages=titleArray.count
        
        pickerView.delegate=self
        pickerView.dataSource=self
        
       
        
     
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tempArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tempArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(tempArray[row] + "Seçildi")
    }
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        cell.lblTitle.text=titleArray[indexPath.row]
        cell.lblMessage.text=messageArray[indexPath.row]
    
        return cell
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    @IBAction func butonClicked(_ sender: Any) {
        YacAlert.ycAlert.showYacAlert(messg: "Deneme alert :)", yacType:.success)
    }
    
}

