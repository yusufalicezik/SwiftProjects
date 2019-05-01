//
//  DropablePin.swift
//  MapCity
//
//  Created by Yusuf ali cezik on 1.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import MapKit

class DropablePin : NSObject, MKAnnotation{//custom pin için gerekli classlar
   
    
    
   dynamic var coordinate: CLLocationCoordinate2D
    var identifier:String
    
    init(coordinate:CLLocationCoordinate2D, identifier:String){
        self.coordinate=coordinate
        self.identifier=identifier
        super.init()
    }
    
    
}
