//
//  Post.swift
//  Wots
//
//  Created by Yusuf ali cezik on 24.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation

class Post {
    var id:String?
    var postImage:String?
    var postedFrom:String?
    var postDate:Date?
    var postLikeCount:Int?
    var postDescription:String?
    var postedFromImage:String?
    
    init(id:String, postImage:String, postedFrom:String, postDate:Date,postLikeCount:Int, postDescription:String, postedFromImage:String){
        self.id = id
        self.postImage = postImage
        self.postedFrom = postedFrom
        self.postDate = postDate
        self.postLikeCount = postLikeCount
        self.postDescription = postDescription
        self.postedFromImage = postedFromImage
    }
    init(){
        
    }
}
