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

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if taskArray.count == 0 {
            tableView.isHidden = true
        }else{
            tableView.isHidden = false
        }
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
        
        return cell
    }
    
    
}
