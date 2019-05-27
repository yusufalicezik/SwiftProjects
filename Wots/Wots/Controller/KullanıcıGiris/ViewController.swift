//
//  ViewController.swift
//  Wots
//
//  Created by Yusuf ali cezik on 16.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        let slides = createSlides()
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        setupSlideScrollView(slides: slides)
        
    }

    @IBAction func ileriButtonClicked(_ sender: Any) {
        if pageControl.currentPage != 2 {
        let maxX = scrollView.contentSize.width - scrollView.frame.width
        let newX = CGFloat(Int(pageControl.currentPage) + 1) * scrollView.frame.width
        if newX <= maxX {
            //pageControl.currentPage = pageControl.currentPage + 1 zaten default olarak scrollViewDidScroll çalıştığında değişiyor, setContentOffsette orası tetiklendiğinden
            scrollView.setContentOffset(CGPoint(x: newX, y: 0), animated: true)
            }
        }else{
            UserDefaults.standard.set("1", forKey: "durum")
             print("set edildi")
            let girisVC = storyboard?.instantiateViewController(withIdentifier: "GirisVC") as? GirisVC
            self.present(girisVC!, animated: true, completion: nil)
        }
    }
    
    @IBAction func geriButtonClicked(_ sender: Any) {
        if pageControl.currentPage != 0 {
            let maxX = self.scrollView.contentSize.width - scrollView.frame.width
        let newX = CGFloat(Int(pageControl.currentPage) - 1) * scrollView.frame.width
        if newX <= maxX {
            //pageControl.currentPage = pageControl.currentPage + 1 zaten default olarak scrollViewDidScroll çalıştığında değişiyor, setContentOffsette orası tetiklendiğinden
            scrollView.setContentOffset(CGPoint(x: newX, y: 0), animated: true)
            }
        }
    }
    
    func createSlides () -> [Slide]{
        let slide1 : Slide = (Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as? Slide)!
        slide1.imageView.image = images[0]
        
        let slide2 : Slide = (Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as? Slide)!
        slide2.imageView.image = images[1]
        
        let slide3 : Slide = (Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as? Slide)!
        slide3.imageView.image = images[2]
        return [slide1,slide2,slide3]
    }
    
    func setupSlideScrollView(slides : [Slide]){
        
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        scrollView.contentSize = CGSize(width: (self.view.frame.width * CGFloat(slides.count)), height: self.view.frame.height - 100)
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: self.view.frame.width * CGFloat(i), y: 0, width: self.view.frame.width, height: self.view.frame.height-0)
            scrollView.addSubview(slides[i])
        }
    }
    
    func setGirisController(){
        var exampleViewController: GirisVC = (storyboard?.instantiateViewController(withIdentifier: "GirisVC") as? GirisVC)!
        
        UIApplication.shared.delegate?.window?!.rootViewController = exampleViewController
        
        UIApplication.shared.delegate?.window?!.makeKeyAndVisible()

    }
        
}
extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / self.view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
}

/*
extension ViewController {
    override func viewWillAppear(_ animated: Bool) {
        girisEkraniKontrolEt()
    }
    
    
    func girisEkraniKontrolEt(){
        print("girdi")
        let giris_durumu = UserDefaults.standard.string(forKey: "giris_durumu") ?? "0" //Eğer sıfırsa uygulamayı ilk açış
        print(giris_durumu)
        if giris_durumu == "0"{
            print("qwe")
            UserDefaults.standard.set("1", forKey: "giris_durumu")

        }else{
            print("qwerty")
            let girisVc = storyboard?.instantiateViewController(withIdentifier: "GirisVC") as? GirisVC
            self.present(girisVc!, animated: false, completion: nil)
        }
    }
}
*/
