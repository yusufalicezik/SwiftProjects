//
//  ViewController.swift
//  CodableExmp
//
//  Created by Yusuf ali cezik on 29.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let url = URL(string: "https://jsonplaceholder.typicode.com/albums")

    override func viewDidLoad() {
        super.viewDidLoad()
        verileriCek()
    }
    func verileriCek(){
        
        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: self.url!) { data, response, error in
                do {
                    let album = try JSONDecoder().decode([Album].self, from: data!)
                    print(album[0].title!)
                    print("************************")
                    
                }catch{
                    print("hata")
                }
                
                
            }
            task.resume()
        }
        
       
        
        
      
    }
    


}

