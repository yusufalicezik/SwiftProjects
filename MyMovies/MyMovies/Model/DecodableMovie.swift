//
//  DecodableMovie.swift
//  MyMovies
//
//  Created by Yusuf ali cezik on 5.05.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import Foundation

class DecodableMovie : Decodable {
    var id:String?
    var title:String?
    
}


class DecodableParentMovie : Decodable{
    var page : String?
    var total_results: String?
    var results : [DecodableMovie]?
}
