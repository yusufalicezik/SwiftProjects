//
//  Task.swift
//  ExtTodo
//
//  Created by Yusuf ali cezik on 4.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation

class Task {
    var name : String?
    var finished:Bool?
    
    init(name:String,finished:Bool) {
        self.name=name
        self.finished=finished
    }
}
