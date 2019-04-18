//
//  RandevuAlViewController.swift
//  NavDraw
//
//  Created by Yusuf ali cezik on 18.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class RandevuAlViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    let secimArray=["Hastane","Bölüm","Doktor","Gün","Saat"]
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.subviews.forEach { $0.removeFromSuperview() }
        tableView.delegate=self
        tableView.dataSource=self
        tableView.tableFooterView = UIView(frame: .zero)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.subviews.forEach { $0.removeFromSuperview() }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secimArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text=secimArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    @IBAction func randevuKaydetButonClicked(_ sender: Any) {
    }
    
}
