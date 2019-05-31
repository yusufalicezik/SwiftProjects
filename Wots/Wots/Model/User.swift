//
//  User.swift
//  Wots
//
//  Created by Yusuf ali cezik on 21.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation

class User {
    var id:String?
    var username:String?
    var password:String?
    var email:String?
    var name_surname:String?
    var profile_image:String?
    
    
    init() {
        
    }
    init(username:String, password:String, email:String, name_surname:String, profile_image:String) {
        self.username = username
        self.password = password
        self.email = email
        self.name_surname = name_surname
        self.profile_image = profile_image
    }
    
    init(id:String, username:String, password:String, email:String, name_surname:String, profile_image:String) {
        self.username = username
        self.password = password
        self.email = email
        self.name_surname = name_surname
        self.profile_image = profile_image
        self.id = id
    }
}
