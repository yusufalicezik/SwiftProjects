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
import AlamofireImage
import Alamofire

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
    
    var flowLayout = UICollectionViewFlowLayout() //collection view ı elle oluşturacağız ve bu layout gerekli
    var collectionView:UICollectionView?
    
    
    var imageUrlArray = [String]()
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        addDoubleTab()
        
        //collectionview islemleri ;
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell") //elle oluşturduğumuz için bu şekilde ekledik cell i
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 0.7397527825)
        
        //3d resim görüntüleme için;
        registerForPreviewing(with: self, sourceView: collectionView!)
        
        pullUpView.addSubview(collectionView!)
        registerForPreviewing(with: self, sourceView: collectionView!)
        
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
        cancelAllSessions()
        pullUpHeighConstraint.constant = 0
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        
        }
    }
    
    func addSpinner(){
        spinner = UIActivityIndicatorView()
        spinner?.center = CGPoint(x: (screenSize.width / 2) - ((spinner?.frame.width)! / 2), y: 150)
        spinner?.style = .whiteLarge
        spinner?.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        spinner?.startAnimating()
        collectionView?.addSubview(spinner!)
    }
    
    func removeSpinner(){
        if spinner != nil {
            spinner?.removeFromSuperview()
        }
    }
    
    
    func addProgressLabel(){
        progressLabel = UILabel()
        progressLabel?.frame = CGRect(x: (screenSize.width / 2)-100, y: 175, width: 200, height: 40)
        progressLabel?.font = UIFont(name: "Avenir Next", size: 18)
        progressLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        progressLabel?.textAlignment = .center
        //progressLabel?.text = "Yükleniyor..."
        collectionView?.addSubview(progressLabel!)
        
    }
    
    func removeProgressLabel(){
        if progressLabel != nil {
            progressLabel?.removeFromSuperview()
        }
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
        
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "dropablePin")
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
        cancelAllSessions()
        removePins() //her tıklamada bi önceki eklenen pini yok etmek için her tıklama da çağırılır, önce harita temizlenir.
        removeSpinner() //her olusturuldugunda iç içe geçmesin diye kaldırıp ekledik.
        removeProgressLabel()
        
        //yeni pindeki resimler yüklenirken arkaplan eski haline dönsün diye
        imageArray = []
        imageUrlArray = []
        collectionView?.reloadData()
        //
        
        
        addSpinner()
        addSwipe()
        addProgressLabel()
        
        let touchPoint = sender.location(in: mapView) //mapview da dokunulan yerin pointini al
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView) //dokunulan noktayı mapviewa göre lokasyona çevirdik
        let annotation = DropablePin(coordinate: touchCoordinate, identifier: "dropablePin") //custom pinimizi yaratmak için bu şekilde yazdık
        
        mapView.addAnnotation(annotation)
        //eklenilen pini(annotation ı) ortalamak için;
        let coordinateRegion = MKCoordinateRegion(center: touchCoordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        //print("Yusuf",flickUrl(key: apiKey, annotation: annotation, pagesNumber: 40))
        
        animateViewUp() //animasyonu kaldırmayı aşağı yazdım çünkü önce konumu alsın ondan sonra heihg i yükseltsin çünkü üste yazarsam noktayı yanlış alıyor.
        retrieveUrl(annotation: annotation) { (bittiMi) in
            if bittiMi {
                self.retrieveImages(handler: { (bittiMi) in
                    if bittiMi {
                       self.removeSpinner()
                       self.removeProgressLabel()
                       self.collectionView?.reloadData()
                        
                    }
                })
            }
        }
    }
    
    
    
    func removePins(){
        for anotation in mapView.annotations {
            mapView.removeAnnotation(anotation)
        }
    }
    
    func retrieveUrl(annotation:DropablePin, handler : @escaping(_ status:Bool)->()){
        imageUrlArray = [] //her seferinde listeyi sıfırlasın ve öyle devam etsin.
        
        Alamofire.request(flickUrl(key: apiKey, annotation: annotation, pagesNumber: 40)).responseJSON { (response) in
            print("yusuf","1")
         
            guard let json = response.result.value as? Dictionary<String, AnyObject> else {return} //ad:Yusuf, yas:21 sol taraf hep stringken sağ taraf herhangi bir değer türü olabilir bu yüzden anyObject
            print("yusuf","2")
            let photosDict = json["photos"] as! Dictionary<String,AnyObject>
            let photosDictArray = photosDict["photo"] as! [Dictionary<String,AnyObject>]
            for photo in photosDictArray {
                let url = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_m_d.jpg"
                self.imageUrlArray.append(url)
                print("yusuf",url)
            }
            handler(true) //true yaptık çağırılan yerdeki handler çalışacak.
            
        }
    }
    
    func retrieveImages(handler : @escaping(_ bittiMi:Bool)->()){
        imageArray=[] //clearladık
        for imageUrl in imageUrlArray{
            Alamofire.request(imageUrl).responseImage { (response) in
                guard let image = response.result.value else {return}
                self.imageArray.append(image)
                self.progressLabel?.text = "\(self.imageArray.count)/\(self.imageUrlArray.count) yükleniyor..."
                
                if self.imageArray.count == self.imageUrlArray.count {
                    handler(true)
                }
            }
        }
    }
    
    func cancelAllSessions(){ // arkaplanda çalışan resimlerin indirilmesini iptal etme.. örneğin swipedown yapıldığında pullUpView gizlendiğinde cancel edilebilir. Ayrıca bi pine tıkladığımızdaki inen fotolar hala inmeye devam ederken başka pine tıklarsak eğer eskisini iptal etmesi de lazım orada da kullanılabilir.
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach({$0.cancel()})
            downloadData.forEach({$0.cancel()})
            
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

extension MapVC:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        
        let imageFromIndex = imageArray[indexPath.row]
        let imageView = UIImageView(image: imageFromIndex)
        cell.addSubview(imageView)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopVC") as? PopVC else {return}
        
        popVC.initData(image: imageArray[indexPath.row])
        self.present(popVC,animated: true,completion: nil)
        
    }
    
}
extension MapVC : UIViewControllerPreviewingDelegate {  //resmin 3d açılımı için
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView?.indexPathForItem(at: location), let cell = collectionView?.cellForItem(at: indexPath) else {return nil}
        
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopVC") as? PopVC else {return nil}
        
        popVC.initData(image: imageArray[indexPath.row])
        
        previewingContext.sourceRect = cell.contentView.frame
        return popVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
  
}



