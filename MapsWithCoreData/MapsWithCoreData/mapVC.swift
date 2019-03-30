//
//  ViewController.swift
//  MapsWithCoreData
//
//  Created by Yusuf ali cezik on 30.03.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class mapVC: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var baslikText: UITextField!
    @IBOutlet weak var aciklamaText: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var secilenKayit=Yer()

    var locationManager=CLLocationManager()//kullanıcının nerde bulunduğunu alabilmek için.
    
    var secilenYer=CLLocationCoordinate2D()
    
    var requestCLLLocation=CLLocation() //inf
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate=self
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest //ne kadar keskin olmalı? en iyi şekilde bul(best ama en çok pil harcar)
        locationManager.requestWhenInUseAuthorization()//always i seçersek sürekli takip eder ama biz when in use kullandık. info plist e eklemeyi unutma-wheninuse
        locationManager.startUpdatingLocation()
        
        
        //pinler için gesture tanımladık. Ama longPress
        
        let recognizer=UILongPressGestureRecognizer(target: self, action:#selector(mapVC.lokasyonSec(gestureRecognizer:)) )
        
        recognizer.minimumPressDuration=2 //kaç saniye basılı kalsın en az?
        mapView.addGestureRecognizer(recognizer)

        if(secilenKayit.baslik != ""){
            self.baslikText.text=secilenKayit.baslik
            self.aciklamaText.text=secilenKayit.aciklama
            gelenKayitlariHaritaraGoster()
        }
        
    }
    
    func gelenKayitlariHaritaraGoster(){
        let pinNokta=MKPointAnnotation()
        pinNokta.coordinate=secilenKayit.location
        pinNokta.title=secilenKayit.baslik
        pinNokta.subtitle=secilenKayit.aciklama
        
        eskiPinleriKaldir()
        self.mapView.addAnnotation(pinNokta)
    }
    
    @objc func lokasyonSec(gestureRecognizer:UILongPressGestureRecognizer){
        //pin yaratmamız lazım;
        //öncesinde gestureRecog. ı kontrol etmemiz gerek.
        if(gestureRecognizer.state==UIGestureRecognizer.State.began){
            let dokunulanNokta=gestureRecognizer.location(in: self.mapView)
            let secilenKoordinatlar=mapView.convert(dokunulanNokta, toCoordinateFrom: mapView)
            //dokunduğumuz noktayı haritaya convert ettik.
            
            secilenYer=secilenKoordinatlar
            
            
            let pinNokta=MKPointAnnotation()
            pinNokta.coordinate=secilenKoordinatlar //lang-long bilgisi tutar.
            pinNokta.title=baslikText.text
            pinNokta.subtitle=aciklamaText.text
            
            //eklemeden hemen önce eski pinleri kaldırmak için;
            eskiPinleriKaldir()
            
            mapView.addAnnotation(pinNokta)
        }
        
    }
    func eskiPinleriKaldir(){
        for i in self.mapView.annotations{
            self.mapView.removeAnnotation(i)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if(secilenKayit.baslik != ""){
            //
            let location=CLLocationCoordinate2D(latitude:secilenKayit.location.latitude ,
                                                longitude:secilenKayit.location.longitude )
            
            let span=MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region=MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
            
        }else{
        
        
        //kullanıcının lokasyonunu alıp bize dizi olarak verir.
        let location=CLLocationCoordinate2D(latitude:locations[0].coordinate.latitude ,
                                            longitude:locations[0].coordinate.longitude )//lokasyon nesnesi yarattık
        
        //ne kadar zoomlanacak?
        let span=MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
       //en son bi bölge yaratırız.
        let region=MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)//haritada set ettik.
        }
        
    }

    @IBAction func kaydetButtonClicked(_ sender: Any) {
        //baslik, altbaslik  ve location ımı kaydetmek için;
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        
        let yeniKonum=NSEntityDescription.insertNewObject(forEntityName: "KaydedilenYerler", into: context)
        
        yeniKonum.setValue(baslikText.text, forKey: "title")
        yeniKonum.setValue(aciklamaText.text, forKey: "subtitle")
        yeniKonum.setValue(secilenYer.latitude, forKey: "latitude")
        yeniKonum.setValue(secilenYer.longitude, forKey: "longitude")
        
        do{
            try context.save()
            print("saved")
        }catch{
            print("Error")
        }
        
        //ekleme yaptığımıza dair bildirim göndermesi için(bi önceki aktiviteye)
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "newPlace"), object: nil)
        
        
        
        
        self.navigationController?.popViewController(animated: true) //kaydetmeden sonra kendimizi bi önceki
        //sayfaya gönderiecek
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //pinleri özelleştirmek için
        
        if(annotation is MKUserLocation){
            return nil //eğer kullanıcının kendi lokasyonu ise bir şey yapma
        }
        let reuseID="myAnnotation"
        var pinView=mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
        
        if pinView == nil{
            pinView=MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView?.canShowCallout=true //yanında buton oluşturmayla ilgili
            pinView?.pinTintColor=UIColor.blue
            let button=UIButton(type: UIButton.ButtonType.infoDark)
        
            pinView?.rightCalloutAccessoryView=button
        }else{
            pinView?.annotation = annotation
        }
        
        //bunlar genelde sabit ezber kodlar.
        return pinView
    }
    
    //callouttaki infoya tıklaınca ne olacak?
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if (secilenKayit.location.latitude != 0) && (secilenKayit.location.longitude != 0){
            self.requestCLLLocation=CLLocation(latitude: secilenKayit.location.latitude, longitude: secilenKayit.location.longitude)
            
        }
        
        CLGeocoder().reverseGeocodeLocation(requestCLLLocation) { (placemarks, error) in
            if let placemark=placemarks{
                if placemark.count>0{
                    let newPlaceMark=MKPlacemark(placemark: placemark[0])
                    let item=MKMapItem(placemark: newPlaceMark)
                    item.name=self.secilenKayit.baslik
                    let launchOptions=[MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                    item.openInMaps(launchOptions: launchOptions)
                }
            }
        }
        
    }
    
}

