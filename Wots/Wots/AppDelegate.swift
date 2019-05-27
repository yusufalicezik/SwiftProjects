//
//  AppDelegate.swift
//  Wots
//
//  Created by Yusuf ali cezik on 16.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let durum = UserDefaults.standard.string(forKey: "durum") ?? "0"
        if durum == "0"{
             print("ilk giris.. 0")
            //ilk kez uygulama açıldı, tanitim ekrani scrollView gelecek. Bir daha da gelmeyecek.
        }else{
            print("artık girmiyor... 1")
            //artık Userdefaults durum acilis controller da son ileriye tıkladıktan sonra 1 olarak set edilti.
            //bu yüzden rootView ı değiştiriz. Değiştirmeden hemen önce de giriş yapılmış mı yapılmamış mı buna bakarız ve yapılmış ise AnasayfaVC, yapılmamışsa GirişVC olarak değiştiriz. Bu duruma göre ilk o controllerlar açılır
            let username = UserDefaults.standard.string(forKey: "username") ?? "Null"
            if username == "Null"{
                self.window = UIWindow(frame: UIScreen.main.bounds)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let viewController = storyboard.instantiateViewController(withIdentifier: "GirisVC") as? GirisVC else {
                    return false
                }
                self.window?.rootViewController = viewController
                self.window?.makeKeyAndVisible()
                
            }else{
                //CurrentUser Güncelleme
                DataService.dataService.CurrentUserTanimla(user: DataService.dataService.girisYapanGetir())
                //
                let loginStoryboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
                guard let tabBarVc = loginStoryboard.instantiateInitialViewController() else {
                    return false
                }
                self.window?.rootViewController = tabBarVc
                self.window?.makeKeyAndVisible()
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

