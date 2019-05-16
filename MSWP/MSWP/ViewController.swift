//
//  ViewController.swift
//  MSWP
//
//  Created by Yusuf ali cezik on 15.05.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var slideScrollView: UIScrollView!
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    var selectedIndex = 0
    
    var images = [UIImage(named: "girisGroup"), UIImage(named: "giris2Group"), UIImage(named: "giris3Group")]
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        slideScrollView.delegate = self
        slideScrollView.scrollsToTop = false
        slideScrollView.showsVerticalScrollIndicator = false
        slideScrollView.showsHorizontalScrollIndicator = false
        
        let slides = createSlides()
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        setupSlideScrollView(slides: slides)
       
        
        
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
        
        slideScrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        slideScrollView.contentSize = CGSize(width: (self.view.frame.width * CGFloat(slides.count)), height: self.view.frame.height - 50)
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: self.view.frame.width * CGFloat(i), y: 0, width: self.view.frame.width, height: self.view.frame.height-50)
            slideScrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / self.view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    @IBAction func ileriButtonClicked(_ sender: Any) {
        //slideScrollView.setContentOffset(CGPoint(x: slideScrollView.contentSize.width, y: 0), animated: true)
        let maxX = slideScrollView.contentSize.width - slideScrollView.frame.width
        let newX = CGFloat(Int(pageControl.currentPage) + 1) * slideScrollView.frame.width
        if newX <= maxX {
            pageControl.currentPage = pageControl.currentPage + 1
            slideScrollView.setContentOffset(CGPoint(x: newX, y: 0), animated: true)
        }

    }
    
    
}



