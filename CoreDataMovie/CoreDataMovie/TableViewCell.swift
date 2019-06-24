//
//  TableViewCell.swift
//  CoreDataMovie
//
//  Created by Yusuf ali cezik on 23.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import CoreData

class TableViewCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var mCategory:String?
    var movies = [Movie]()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
          //gelen kategoriye göre olan filmleri çekeceğiz.
//        movies.append(Movie(name: "Film 1", category: "Kategori1"))
//        movies.append(Movie(name: "Film 2", category: "Kategori1"))
//        movies.append(Movie(name: "Film 3", category: "Kategori1"))
//        movies.append(Movie(name: "Film 4", category: "Kategori1"))
//        movies.append(Movie(name: "Film 5", category: "Kategori1"))
//        movies.append(Movie(name: "Film 6", category: "Kategori1"))
    }
    
    func configureCell(category:String){
        categoryName.text = category
        mCategory = category
        movies = []
        retrieveMoviesWithCategory()
    }

    func retrieveMoviesWithCategory(){
        if let mcCategory = mCategory {
            print("Kategori : \(mcCategory)")
            //filmleri çekeceğiz kategoriye göre.
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate?.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieX")
            fetchRequest.predicate = NSPredicate(format: "category = %@", mcCategory)
            fetchRequest.returnsObjectsAsFaults = false
            do{
                let result = try context?.fetch(fetchRequest)
                for data in result as! [NSManagedObject]{
                    let mMovie = Movie()
                    mMovie.name = data.value(forKey: "name") as? String
                    mMovie.category = data.value(forKey: "category") as? String
                    mMovie.image = data.value(forKey: "image") as? Data
                    movies.append(mMovie)
                }
                collectionView.reloadData()
            }catch{
                
            }
            
        }else{
            print("girmedi")
        }
    }


}
extension TableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cCell", for: indexPath) as? CollectionViewCell
        cell?.movieNameLabel.text = movies[indexPath.row].name!
        cell?.imageView.image = UIImage(data: movies[indexPath.row].image!)
        return cell!
    }
    
    
}
