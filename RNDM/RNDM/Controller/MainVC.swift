//
//  ViewController.swift
//  RNDM
//
//  Created by Yusuf ali cezik on 11.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import Firebase

enum ThoughtCategory : String {
    
    case ciddi = "ciddi"
    case eglenceli = "eğlenceli"
    case cilgin = "çılgın"
    case popular = "popüler"
}

class MainVC: UIViewController {
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    private var thoughts = [Thought]()
    private var thoughtsCollectionRef : CollectionReference!
    private var thoughtsListener : ListenerRegistration!
    private var selectedCategory = ThoughtCategory.eglenceli.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        thoughtsCollectionRef = Firestore.firestore().collection(THOUGHTS_REF)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       setListener()
        

    }
    
    
    func setListener(){
       
        //
        
        
        if selectedCategory == ThoughtCategory.popular.rawValue {
             thoughts=[]
            thoughtsListener = thoughtsCollectionRef
                .order(by: NUM_LIKES, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    if let _ = error {
                        print("error fethcing docs")
                    }else{
                        
                        guard let snap = snapshot else {return}
                        for document in snap.documents {
                            let data = document.data()
                            let username = data[USERNAME] as? String ?? "Anonymous"
                            //let timestamp = data[TIMESTAMP] as? Date ?? Date()
                            let thoughtText = data[THOUGHTS_TXT] as? String ?? ""
                            let timestampDt = data[TIMESTAMP] as? Timestamp ?? Timestamp()
                            let numLikes = data[NUM_LIKES] as? Int ?? 0
                            let numComments = data[NUM_COMMENTS] as? Int ?? 0
                            let documentID = document.documentID
                            
                            let date = Date(timeIntervalSince1970: TimeInterval(timestampDt.seconds))
                            
                            
                            let tempThought = Thought(username: username, timestamp: date, thoughtTxt: thoughtText, numLikes: numLikes, numComments: numComments, documentID: documentID)
                            
                            self.thoughts.append(tempThought)
                        }
                        self.tableView.reloadData()
                    }
            }
        }else{
        thoughts=[]
        thoughtsListener = thoughtsCollectionRef.whereField(CATEGORY, isEqualTo: selectedCategory)
            .order(by: TIMESTAMP, descending: true)
            .addSnapshotListener { (snapshot, error) in
                if let _ = error {
                    print("error fethcing docs")
                }else{
                    
                    guard let snap = snapshot else {return}
                    for document in snap.documents {
                        let data = document.data()
                        let username = data[USERNAME] as? String ?? "Anonymous"
                        //let timestamp = data[TIMESTAMP] as? Date ?? Date()
                        let thoughtText = data[THOUGHTS_TXT] as? String ?? ""
                        let timestampDt = data[TIMESTAMP] as? Timestamp ?? Timestamp()
                        let numLikes = data[NUM_LIKES] as? Int ?? 0
                        let numComments = data[NUM_COMMENTS] as? Int ?? 0
                        let documentID = document.documentID
                        
                        let date = Date(timeIntervalSince1970: TimeInterval(timestampDt.seconds))
                        
                        
                        let tempThought = Thought(username: username, timestamp: date, thoughtTxt: thoughtText, numLikes: numLikes, numComments: numComments, documentID: documentID)
                        
                        self.thoughts.append(tempThought)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        thoughtsListener.remove()
    }

    @IBAction func categorySegmentChanged(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.eglenceli.rawValue
        case 1:
            selectedCategory = ThoughtCategory.ciddi.rawValue
        case 2:
            selectedCategory = ThoughtCategory.cilgin.rawValue
        case 3:
            selectedCategory = ThoughtCategory.popular.rawValue
        default :
            selectedCategory = ThoughtCategory.eglenceli.rawValue

        }
        
        
        thoughtsListener.remove()
        setListener()
    }
    
}
extension MainVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ThoughtCell else { return UITableViewCell()}

        cell.configureCell(thought: thoughts[indexPath.row])
        return cell
    }
    
    
}

