//
//  ViewController.swift
//  CoreDataMovie
//
//  Created by Yusuf ali cezik on 23.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    var appDelegate : AppDelegate?
    var categories = [Category]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        categories = []
        categories.append(Category(categoryName: "Aksiyon"))
        categories.append(Category(categoryName: "Bilim Kurgu"))
        categories.append(Category(categoryName: "Korku"))
        categories.append(Category(categoryName: "Gerilim"))
        categories.append(Category(categoryName: "Gençlik"))
        categories.append(Category(categoryName: "Komedi"))
        self.tableView.reloadData()
    }


}
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mCell = tableView.dequeueReusableCell(withIdentifier: "tCell", for: indexPath) as! TableViewCell
        mCell.configureCell(category:categories[indexPath.row].categoryName!)
        mCell.mCategory = categories[indexPath.row].categoryName!
        return mCell
        
    }
    
    
}

