//
//  ViewController.swift
//  LoginWithPageview
//
//  Created by Yusuf ali cezik on 8.04.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
   
    var titleArray=["Hoş Geldiniz", "WApp Nedir?","Başlarken"]
    var messageArray=["App hakkında daha fazla bildi almak için lütfen kaydırın.", "Bu app ile sosyal medyada istediğin gibi gezebilir, paylaşımlar yapabilir, beğenip yorum yapabilir ve takipçilerin ile dilediğin gibi mesajlaşabilirsin.","Başlamak için son kez kaydır ve wApp'e kayıt ol."]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate=self
        collectionView.dataSource=self
        pageControl.numberOfPages=titleArray.count
        
     
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

