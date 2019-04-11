//
//  ViewController.swift
//  ToDo
//
//  Created by Yusuf ali cezik on 10.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{

    var itemArray=[Item]()
    
    let defaults=UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK - Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        cell.textLabel?.text=itemArray[indexPath.row].title
        
        /*if itemArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
         }*///yerine aşağıdaki;
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
        return cell
    }
    
    //Mark - Tableview delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
      /*  if itemArray[indexPath.row].done==true{
            itemArray[indexPath.row].done=false
        }else{
            itemArray[indexPath.row].done=true
        }
         *///yerine aşağıdaki;
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }


    //Mark - Add new Items
    @IBAction func addButtonPressed(_ sender: Any) {
    
        var textField=UITextField()
        let alert=UIAlertController(title: "Yeni Kategori", message: "Yeni Kategori eklenecek", preferredStyle: UIAlertController.Style.alert)
        
        let action=UIAlertAction(title:"Ekle", style: UIAlertAction.Style.default) { (action) in
            //ekleye tıklanınca ne olacak?
            if textField.text != nil && textField.text != "" {
                let item=Item()
                item.title=textField.text!
               self.itemArray.append(item)
                self.tableView.reloadData()
            }
           
            
            }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Kategori Adı Girin"
            textField=alertTextField
          
        }
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

