//
//  ViewController.swift
//  TimerGestureAndAlert
//
//  Created by Yusuf ali cezik on 10.03.2019.
//  Copyright © 2019 Yusuf ali cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var labelSure: UILabel!
    @IBOutlet weak var labelSkor: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var img7: UIImageView!
    @IBOutlet weak var img8: UIImageView!
    @IBOutlet weak var img9: UIImageView!
    @IBOutlet weak var labelBolum: UILabel!
    @IBOutlet var viewController: UIView!
    
    let seviye1Saniye=1
    let seviye2Saniye=0.8
    let seviye3Saniye=0.7
    let seviye4Saniye=0.6
    let seviye5Saniye=0.5
    let seviye6Saniye=0.2
    
    
    
    var skor=0
    var sayac=15
    var bolumSeviyesi=1
    
    var timer=Timer()
    var timer2=Timer()
    var imgDizi=[UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        tanimlamalariYap()
        oyunuBaslat()
        
        
        
    }
    func oyunuBaslat(){
        
        sayac=15
        skor=0
        labelSkor.text=String(skor)
        labelSure.text="\(sayac)"
        labelBolum.text="Bölüm \(bolumSeviyesi)"
        
        
        oynatmaGizleme()
        
          timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.zamanlayici), userInfo: nil, repeats: true)
        if(bolumSeviyesi==1){
            timer2=Timer.scheduledTimer(timeInterval: TimeInterval(seviye1Saniye), target: self, selector: #selector(ViewController.oynatmaGizleme), userInfo: nil, repeats: true)
        }else if(bolumSeviyesi==2){
            timer2=Timer.scheduledTimer(timeInterval: seviye2Saniye, target: self, selector: #selector(ViewController.oynatmaGizleme), userInfo: nil, repeats: true)
        }else if(bolumSeviyesi==3){
            timer2=Timer.scheduledTimer(timeInterval: seviye3Saniye, target: self, selector: #selector(ViewController.oynatmaGizleme), userInfo: nil, repeats: true)
        }else if(bolumSeviyesi==4){
            timer2=Timer.scheduledTimer(timeInterval: seviye4Saniye, target: self, selector: #selector(ViewController.oynatmaGizleme), userInfo: nil, repeats: true)
        }else if(bolumSeviyesi==5){
            timer2=Timer.scheduledTimer(timeInterval: seviye5Saniye, target: self, selector: #selector(ViewController.oynatmaGizleme), userInfo: nil, repeats: true)
        }else{
            timer2=Timer.scheduledTimer(timeInterval: seviye6Saniye, target: self, selector: #selector(ViewController.oynatmaGizleme), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func oynatmaGizleme(){
        for i in imgDizi{
            i.isHidden=true
        }
        
        let randomSayi=Int(arc4random_uniform(UInt32(Int(imgDizi.count-1))))
        
        imgDizi[randomSayi].isHidden=false
        
        
        
    }
    
    func tanimlamalariYap(){
        
        
        img1.isUserInteractionEnabled=true
        img2.isUserInteractionEnabled=true
        img3.isUserInteractionEnabled=true
        img4.isUserInteractionEnabled=true
        img5.isUserInteractionEnabled=true
        img6.isUserInteractionEnabled=true
        img7.isUserInteractionEnabled=true
        img8.isUserInteractionEnabled=true
        img9.isUserInteractionEnabled=true
        
         let recognizer=UITapGestureRecognizer(target: self, action: #selector(ViewController.skoruArttir))
         let recognizer1=UITapGestureRecognizer(target: self, action: #selector(ViewController.skoruArttir))
         let recognizer2=UITapGestureRecognizer(target: self, action: #selector(ViewController.skoruArttir))
         let recognizer3=UITapGestureRecognizer(target: self, action: #selector(ViewController.skoruArttir))
         let recognizer4=UITapGestureRecognizer(target: self, action: #selector(ViewController.skoruArttir))
         let recognizer5=UITapGestureRecognizer(target: self, action: #selector(ViewController.skoruArttir))
         let recognizer6=UITapGestureRecognizer(target: self, action: #selector(ViewController.skoruArttir))
         let recognizer7=UITapGestureRecognizer(target: self, action: #selector(ViewController.skoruArttir))
         let recognizer8=UITapGestureRecognizer(target: self, action: #selector(ViewController.skoruArttir))
        
        img1.addGestureRecognizer(recognizer)
        img2.addGestureRecognizer(recognizer1)
        img3.addGestureRecognizer(recognizer2)
        img4.addGestureRecognizer(recognizer3)
        img5.addGestureRecognizer(recognizer4)
        img6.addGestureRecognizer(recognizer5)
        img7.addGestureRecognizer(recognizer6)
        img8.addGestureRecognizer(recognizer7)
        img9.addGestureRecognizer(recognizer8)
        
        
        
        imgDizi.append(img1)
        imgDizi.append(img2)
        imgDizi.append(img3)
        imgDizi.append(img4)
        imgDizi.append(img5)
        imgDizi.append(img6)
        imgDizi.append(img7)
        imgDizi.append(img8)
        imgDizi.append(img9)
        
        
        
        
    }
    
    @objc func skoruArttir(){
        skor=skor+1
        labelSkor.text=String(skor)
       
    }
    
    @objc func zamanlayici(){
        sayac=sayac-1
        labelSure.text="\(sayac)"
        if(sayac==0){
            timer.invalidate()
            timer2.invalidate()
            var alert:UIAlertController
            if(skor>=5){
                  alert=UIAlertController(title: "Tebrikler, bölümü geçtin", message: "Puanın : \(skor) Sonraki bölüme geçmek ister misin?", preferredStyle: UIAlertController.Style.alert)
                bolumSeviyesi=bolumSeviyesi+1
            }else{
                  alert=UIAlertController(title: "Süre Bitti! Maalesef geçemedin", message: "Puanın : \(skor) Yeniden başlamak ister misin?", preferredStyle: UIAlertController.Style.alert)
                bolumSeviyesi=1
            }
           
            let evetButon=UIAlertAction(title: "Evet", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.oyunuBaslat()
            }
            alert.addAction(evetButon)
            self.present(alert,animated: true,completion: nil)
            
        }
    }


}

