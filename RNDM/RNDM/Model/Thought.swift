//
//  Thought.swift
//  RNDM
//
//  Created by Yusuf ali cezik on 11.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation


class Thought {
    
    private(set) var username : String!
    private(set) var timestamp : Date!
    private(set) var thoughtTxt : String!
    private(set) var numLikes : Int!
    private(set) var numComments : Int!
    private(set) var documentID : String!

    
    
    init(username:String, timestamp:Date, thoughtTxt:String, numLikes:Int, numComments:Int,documentID:String) {
        self.username=username
        self.timestamp=timestamp
        self.numLikes=numLikes
        self.thoughtTxt=thoughtTxt
        self.numComments=numComments
        self.documentID=documentID
    }
    
}
