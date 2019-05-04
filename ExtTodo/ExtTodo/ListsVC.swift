//
//  ViewController.swift
//  ExtTodo
//
//  Created by Yusuf ali cezik on 4.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ListsVC: UIViewController {
    
    
    var taskArray=[Task]()

  
    @IBOutlet weak var emptyView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //statics
        taskArray.append(Task(name: "Deneme 1", finished: false))
        taskArray.append(Task(name: "Deneme 2", finished: true))
        taskArray.append(Task(name: "Deneme 3", finished: false))
        taskArray.append(Task(name: "Deneme 4", finished: false))
        
        //
        tableView.delegate = self
        tableView.dataSource = self
        
        //boş rowları gizlemek için;
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       listeyiKontrolEt()
    }
    
    func listeyiKontrolEt(){
        if taskArray.count == 0 {
            tableView.isHidden = true
            emptyView.isHidden = false
        }else{
            emptyView.isHidden = true
            tableView.isHidden = false
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func addNewButtonClicked(_ sender: Any) {
        guard let addTaskVC = storyboard?.instantiateViewController(withIdentifier: "AddTaskVC") as? AddTaskVC else { return}
        presentAddTaskVC(addTaskVC)
    }
    
}

extension ListsVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomTableviewCell else { return UITableViewCell()}
        
        cell.confData(task: taskArray[indexPath.row])
        print(taskArray[indexPath.row].name!)
        return cell
    }
    
    
    ///DeSELECT
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    ///swipe ederek düzenleyebilme/silebilme
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "Sil") { (rowAction, indexPath) in
            self.taskArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            self.listeyiKontrolEt()
            
        }
        
        let finishedAction = UITableViewRowAction(style: UITableViewRowAction.Style.normal, title: "Yapıldı") { (rowAction, indexPath) in
            self.taskArray[indexPath.row].finished = true
            self.tableView.reloadData()
            
        }
        
        
        finishedAction.backgroundColor = #colorLiteral(red: 0.3621281683, green: 0.3621373773, blue: 0.3621324301, alpha: 0.8042594178)
        return [deleteAction, finishedAction]
    }
    
    
    
    
    
}
