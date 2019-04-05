//
//  DiscoverCell.swift
//  MyMovies
//
//  Created by Yusuf ali cezik on 5.04.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit

class DiscoverCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {

    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryIDLabel: UILabel!
    
    //ya da tıkladığımda movieArray[indpath.row] daki id yi selected id olarak yollarım. bu olur
    //burda collectiondaki movie name in altına gizli id ekleriz yine.
    //tıkladığında detaylara gidecek ve o id ye göre tıklanılan filmi seçecek.
    
    var movieArray=[Movie]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryIDLabel.isHidden=true
        collectionView.delegate=self
        collectionView.dataSource=self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func allButonClicked(_ sender: Any) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:indexPath) as! DiscoverFilmCollectionCell
        
        
        
        return cell
    }
    
}
