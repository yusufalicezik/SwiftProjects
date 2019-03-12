//
//  ViewController.swift
//  TableViewWithClass
//
//  Created by Yusuf ali cezik on 11.03.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var FamilyGuys=[FamilyKarakter]()
    var secilenFamilyKarakter=FamilyKarakter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate=self
        tableView.dataSource=self
        
        //Family Class
        let meg=FamilyKarakter()
        meg.isim="Meg"
        meg.meslek="Öğrenci"
        meg.resim=UIImage(named: "meg.png")!
        
        let brian=FamilyKarakter()
        brian.isim="Brian"
        brian.meslek="Köpek"
        brian.resim=UIImage(named: "brian.png")!
        
        let stewie=FamilyKarakter()
        stewie.isim="Stewie"
        stewie.meslek="Bebek"
        stewie.resim=UIImage(named: "stewie.jpg")!
        
        
        let peter=FamilyKarakter()
        peter.isim="Peter"
        peter.meslek="Fabrika işçisi"
        peter.resim=UIImage(named: "peter.png")!
      
        
        FamilyGuys.append(meg)
        FamilyGuys.append(brian)
        FamilyGuys.append(stewie)
        FamilyGuys.append(peter)

        /////
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FamilyGuys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        cell.textLabel?.text=FamilyGuys[indexPath.row].isim
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        secilenFamilyKarakter.isim=FamilyGuys[indexPath.row].isim
        secilenFamilyKarakter.meslek=FamilyGuys[indexPath.row].meslek
        secilenFamilyKarakter.resim=FamilyGuys[indexPath.row].resim
        
        
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="toDetailsVC"){
            
            let destinationVC=segue.destination as! DetailsVC
            destinationVC.familyKarakter=self.secilenFamilyKarakter
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            FamilyGuys.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    


}

