//
//  Movie.swift
//  CoreDataMovie
//
//  Created by Yusuf ali cezik on 23.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import UIKit
class Movie{
    var name:String?
    var category:String?
    var image:Data?
    
    init(){
        
    }
    
    init(name:String, category:String){
        self.name = name
        self.category = category
    }
}
