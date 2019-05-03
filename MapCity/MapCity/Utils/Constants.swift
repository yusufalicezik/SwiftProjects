//
//  Constants.swift
//  MapCity
//
//  Created by Yusuf ali cezik on 3.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation

let apiKey = "2e813352b4225f7db2d993b7942e5f3b"

func flickUrl(key: String, annotation:DropablePin, pagesNumber:Int)->String{

    return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(key)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=mi&per_page=\(pagesNumber)&format=json&nojsoncallback=1"
}

/*
 https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=175019b1c16b07c60b1318bfead6f208&lat=32.23123&lon=35.31231&radius=1&radius_units=mi&per_page=40&format=json&nojsoncallback=1
 
 */
