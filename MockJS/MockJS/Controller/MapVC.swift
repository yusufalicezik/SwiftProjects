//
//  MapVC.swift
//  MockJS
//
//  Created by Yusuf ali cezik on 9.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var  customView = Bundle.main.loadNibNamed("CustomXib", owner: self, options: nil)?.first as! CustomXib
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addDoubleTab()
        
       
    }
    func addDoubleTab(){
       
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(haritaKonumSec(sender:)))
        recognizer.numberOfTapsRequired = 2
        recognizer.delegate = self
        mapView.addGestureRecognizer(recognizer)
    }
    @objc func haritaKonumSec(sender : UITapGestureRecognizer){
        
        for an in mapView.annotations {
            mapView.removeAnnotation(an)
        }
        
        
        
        
        
        
        let touchPoint = sender.location(in: mapView) //mapview da dokunulan yerin pointini al
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchCoordinate
        ///
        
      
        
        
        customView.layer.cornerRadius = 10
        customView.frame = CGRect(x: touchPoint.x - customView.frame.width / 2, y: touchPoint.y - customView.frame.height / 1.2, width: customView.frame.width, height: customView.frame.height)
        
        customView.onerConfig(onerilecekKonum: "\(touchCoordinate.latitude)")
        self.view.addSubview(customView)
        
        
        
        
        ///
        self.mapView.addAnnotation(annotation)
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
