//
//  ViewController.swift
//  ToDo
//
//  Created by Yusuf ali cezik on 10.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{

    var itemArray=[Item]()
    var selectedCategory:Category? {
        didSet{
            loadItems()
        }
    }
    
    let defaults=UserDefaults.standard
    
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sqllite ile v.tabanını açabilmemiz için dosya yolu gerekli. Bunu almak için; library supporting files
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    //MARK: - Tableview datasource methods
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
    
    //MARK: - Tableview delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
      /*  if itemArray[indexPath.row].done==true{
            itemArray[indexPath.row].done=false
        }else{
            itemArray[indexPath.row].done=true
        }
         *///yerine aşağıdaki;
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.deselectRow(at: indexPath, animated: true)
        saveItems()
        
        
        //silmek için;
        /*
         context.delete(itemArray[indexPath.row]) önce bu silinir, daha sonra itemArrayden remove edilir, index
         sırası kaymaması İÇİN
         itemArray.remove(indexPath.row)
         
         saveItems()
         */
        
    }


    //MARK: - Add new Items
    @IBAction func addButtonPressed(_ sender: Any) {
    
        var textField=UITextField()
        let alert=UIAlertController(title: "Yeni Görev", message: "Yeni görev eklenecek", preferredStyle: UIAlertController.Style.alert)
        
        let action=UIAlertAction(title:"Ekle", style: UIAlertAction.Style.default) { (action) in
            //ekleye tıklanınca ne olacak?
            if textField.text != nil && textField.text != "" {
                let item=Item(context: self.context)
                item.title=textField.text!
                item.done=false
                item.parentCategory=self.selectedCategory
               self.itemArray.append(item)
                self.saveItems()
               
            }
           
            
            }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Görev Adı Girin"
            alertTextField.addConstraint(alertTextField.heightAnchor.constraint(equalToConstant: 35))
            alertTextField.backgroundColor=#colorLiteral(red: 0.1492741827, green: 0.6032516106, blue: 0.6764355964, alpha: 0.6923426798)
            alertTextField.layer.borderWidth=0
            alertTextField.layer.borderColor=#colorLiteral(red: 0.1492741827, green: 0.6032516106, blue: 0.6764355964, alpha: 0.6923426798)
            alertTextField.borderStyle = .roundedRect
            
            
            textField=alertTextField
          
        }
        
        
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        do{
            try context.save()
            print("saved")
            tableView.reloadData()
        }catch{
            print("error while saving")
        }
    }
    
    //default olarak Item.feth.. verdik, eğer request parametresi gelmezse/göndermezsek/boş gönderirsek diye
    func loadItems(request:NSFetchRequest<Item>=Item.fetchRequest(),predicate:NSPredicate?=nil){
        
        let parentPredicate=NSPredicate(format: "parentCategory.name MATCHES %@", (selectedCategory?.name!)!)
        if let additionalPredicate=predicate{
            request.predicate=NSCompoundPredicate(andPredicateWithSubpredicates: [additionalPredicate,parentPredicate])
        }else{
            request.predicate=parentPredicate
        }
       
        
        do{
           itemArray = try context.fetch(request)
            tableView.reloadData()
        }catch{}
    }
    
    
   
    
}

//MARK: - Search bar extension
extension TodoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        if searchBar.text != nil && searchBar.text != ""{
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        //Query yazmak için ; //cd büyük küçük harf duyarlılığını ortadan kaldırır.
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors=[sortDescriptor]
        
            loadItems(request: request,predicate:predicate)
        }
        else{
          self.loadItems()
        }
        
        
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != nil && searchBar.text != ""{
            
            let request : NSFetchRequest<Item> = Item.fetchRequest()
            
            //Query yazmak için ; //cd büyük küçük harf duyarlılığını ortadan kaldırır.
            let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
            
            request.predicate=predicate
            
            let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
            request.sortDescriptors=[sortDescriptor]
            
            loadItems(request: request)
        }
        else{
            self.loadItems()
        }
        
        
    }
    
    
}
