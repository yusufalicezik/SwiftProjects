//
//  ViewController.swift
//  CoreDataMovie
//
//  Created by Yusuf ali cezik on 23.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import CoreData
import UIWindowTransitions
import Pastel

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
        backgroundConf()
        self.tableView.reloadData()
    }
    func backgroundConf(){
        let pastelView = PastelView(frame: view.bounds)
        // Custom Direction
        pastelView.startPastelPoint = .topLeft
        pastelView.endPastelPoint = .bottomRight
        
        // Custom Duration
        pastelView.animationDuration = 2.0
        
        // Custom Color
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 0.7),
                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 0.7),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 0.7),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 0.7),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 0.7),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 0.7),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 0.7)])
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
        
    }

    @IBAction func addNewClicked(_ sender: Any) {
        let addNewVC = storyboard?.instantiateViewController(withIdentifier: "AddNewVC") as! AddNewVC
//        let wnd = UIApplication.shared.keyWindow
//        var options = UIWindow.TransitionOptions()
//        options.direction = .toRight
//        options.duration = 0.37
//        options.style = .easeInOut
//        options.background = nil
//        wnd?.setRootViewController(addNewVC, options: options)
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(addNewVC, animated: false, completion: nil)

        
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

