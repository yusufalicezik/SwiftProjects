//
//  ViewController.swift
//  DifTable
//
//  Created by Yusuf ali cezik on 13.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
      

    }


}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as? TableViewCellEmpty, let cellTemp = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
            }
            cellTemp.dissViewHeight()
            cellTemp.accessoryType = .none
            cellTemp.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            return cellTemp
            
        }else{
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {return UITableViewCell()}
        return cell
        }
    }
}

