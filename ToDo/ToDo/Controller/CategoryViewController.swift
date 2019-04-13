//
//  CategoryViewController.swift
//  ToDo
//
//  Created by Yusuf ali cezik on 13.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray=[Category]()
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        loadData()
    }

    
    //MARK: Tableview datasource methods //temel
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text=categoryArray[indexPath.row].name
        print(categoryArray.count)
        
        return cell
    }
    
    
    //Mark: Delegate Methods //tıklama vs
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath=tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory=categoryArray[indexPath.row]
        }
    }
    
    
    //Mark: Data manipulation //load data, save data vs
    func loadData(){
        let request:NSFetchRequest<Category> = Category.fetchRequest()
        do {categoryArray = try context.fetch(request)
            tableView.reloadData()
        }catch{
            print("çekme hatası")
        }
    }
    
    func saveData(){
        do{
            try context.save()
            tableView.reloadData()
            print("saved")
        }catch{
            print("error")
        }
    }
    
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        var textField=UITextField()
        let alert = UIAlertController(title: "Yeni Kategori", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Ekle", style: UIAlertAction.Style.default) { (action) in
            //Ekle denildiğinde yapılacaklar//
            
            let tempCategory=Category(context: self.context)
            tempCategory.name=textField.text
            self.categoryArray.append(tempCategory)
           self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Kategori adı girin"
           alertTextField.addConstraint(alertTextField.heightAnchor.constraint(equalToConstant: 35))
            textField=alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    

    
}
