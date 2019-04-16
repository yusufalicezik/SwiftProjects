//
//  ViewController.swift
//  CustomPopup
//
//  Created by Yusuf ali cezik on 15.04.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var secilenTarihLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       // let sb = UIStoryboard(name: "CustomPopupStoryboard", bundle: nil)
    /*    let vc = self.storyboard?.instantiateViewController(withIdentifier:"secondVC") as! SecondViewController
      vc.delegate = self
 */
        izinAl()
        bildirimAyarla()
    
    }

    

    @IBAction func tarihSecClicked(_ sender: Any) {
       performSegue(withIdentifier: "mySegue", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass the selected object to the new view controller.
        if segue.identifier == "mySegue" {
            let vc : CustomPopupViewController = segue.destination as! CustomPopupViewController
            vc.popupDelegate = self
        }
    }
    
    
    func bildirimAyarla(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests() //daha önceden bi notification varsa bunu silmek istiyoruz. en güncel olanı göndermek için;
        
        let content = UNMutableNotificationContent()
        content.title = "Selam"
        content.body = "2 Yeni mesajın var"
        content.badge = 2
        content.sound = UNNotificationSound.default
        
        //2 farklı şekilde gönderelim;
        // 1 - Trigger 15 saniye sonra gönder
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        
        //2 zaman odaklı ;
        let date = Date(timeIntervalSinceNow: 3600) //1 saat sonra..
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .minute], from: date)
        
        
        let identifier = "DenemeNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        //oluşturduğmuz requesti ekleyelim ;
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("hata")
            }else{
                
            }
        }
    }
    
    func izinAl(){
        let options : UNAuthorizationOptions = [.alert, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (izin, error) in
            if !izin{
                print("izin verilmedi")
            }
        }
    }
    
    
}

extension ViewController : PopupDataDelegate{
    func tarihSec(secilenTarih: String) {
        secilenTarihLabel.text = secilenTarih
        print("seçildi :D")
    }
    
    
}
