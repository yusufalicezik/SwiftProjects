//
//  ViewController.swift
//  MapCity
//
//  Created by Yusuf ali cezik on 1.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var pullUpView: UIView!
    
    
    @IBOutlet weak var pullUpHeighConstraint: NSLayoutConstraint!
    
    let locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius : Double = 1000 //1000 m karelik bölge
    var screenSize = UIScreen.main.bounds
    
    
    var spinner:UIActivityIndicatorView?
    var progressLabel:UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        addDoubleTab()
        addSwipe()
        
    }
    
    func addDoubleTab(){
        let doubleTab = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender:)))
        doubleTab.numberOfTapsRequired = 2
        doubleTab.delegate = self
        mapView.addGestureRecognizer(doubleTab)
        
        
    }
    
    func addSwipe(){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(animateViewDown))
        swipe.direction = .down
        pullUpView.addGestureRecognizer(swipe)
    }
    
   
    
    func animateViewUp(){
        pullUpHeighConstraint.constant = 300 //view ı görünür yaptık yani
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded() //guncelle layoutu (animasyonlu bir şekilde)
        }
    }
    
    @objc func animateViewDown(){
        
        pullUpHeighConstraint.constant = 0
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        
        }
    }
    
    func addSpinner(){
        spinner = UIActivityIndicatorView()
        spinner?.center = CGPoint(x: (screenSize.width / 2) - ((spinner?.frame.width)! / 2), y: 150)
        spinner?.style = .whiteLarge
        spinner?.color = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 0.7397527825)
        spinner?.startAnimating()
        pullUpView.addSubview(spinner!)
    }
    
    

    @IBAction func centerMapButtonPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
    
}

extension MapVC : MKMapViewDelegate {
    
    //custom annotation için
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //kendi lokasyonumu da pin şeklinde göstermemesi için eğer lokasyon benim ise direkt return yapıyorum
        if annotation is MKUserLocation {
            return nil
        }
        
        
        var pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "dropablePin")
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 0.7397527825)
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
    
   
    //konumu bulduktan sonra ortalamak ve 1000 m2 lik alanı gösterebilmek için.
    //bunu authLocationStatus değiştikten sonra çağırırız.
    func centerMapOnUserLocation(){
        guard let coordinate = locationManager.location?.coordinate else {return }
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    @objc func dropPin(sender : UITapGestureRecognizer){ //haritada drop pin yapmak için (dokunulan noktayı alabilmek için parametre olarak dokunulan yeri aldık)
        removePins() //her tıklamada bi önceki eklenen pini yok etmek için her tıklama da çağırılır, önce harita temizlenir.
        animateViewUp()
        addSpinner()
        
        let touchPoint = sender.location(in: mapView) //mapview da dokunulan yerin pointini al
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView) //dokunulan noktayı mapviewa göre lokasyona çevirdik
        let annotation = DropablePin(coordinate: touchCoordinate, identifier: "dropablePin") //custom pinimizi yaratmak için bu şekilde yazdık
        
        mapView.addAnnotation(annotation)
        //eklenilen pini(annotation ı) ortalamak için;
        let coordinateRegion = MKCoordinateRegion(center: touchCoordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    func removePins(){
        for anotation in mapView.annotations {
            mapView.removeAnnotation(anotation)
        }
    }
    
}

extension MapVC : CLLocationManagerDelegate {
    func configureLocationServices(){
        if authorizationStatus == .notDetermined { //belirlenmemiş ise
            locationManager.requestAlwaysAuthorization() //belirlemek için iste
        }else {
            return
        }
    }
    
    //crash yememek için location değiştikten sonra çağırılsın metod
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
}

