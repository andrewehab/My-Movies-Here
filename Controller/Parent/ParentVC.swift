//
//  ViewController.swift
//  PagerStripDemo
//
//  Created by Sayalee on 4/19/18.
//  Copyright © 2018 Assignment. All rights reserved.

import UIKit
import XLPagerTabStrip

class ParentVC: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        configureButtonBar()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Configuration
    func configureButtonBar() {
        
        settings.style.buttonBarBackgroundColor = #colorLiteral(red: 0.1294117647, green: 0.6235294118, blue: 0.8784313725, alpha: 1)
        settings.style.buttonBarItemBackgroundColor = #colorLiteral(red: 0.1294117647, green: 0.6235294118, blue: 0.8784313725, alpha: 1)
        
        settings.style.buttonBarItemFont = UIFont(name: "Helvetica", size: 16.0)!       
        settings.style.buttonBarItemTitleColor = .white
        
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        settings.style.selectedBarHeight = 3.0
        settings.style.selectedBarBackgroundColor = .white
        
        // Changing item text color on swipe
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .white
            newCell?.label.textColor = .black
        }
    }
    
    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1 = UIStoryboard.init(name: "NowPlayingMovies", bundle: nil).instantiateViewController(withIdentifier: "NowPlayingVC") as! NowPlayingVC
        
        
        let child2 = UIStoryboard.init(name: "PopularMovies", bundle: nil).instantiateViewController(withIdentifier: "PopularVC") as! PopularVC
        
        let child3 = UIStoryboard.init(name: "TopRatedMovies", bundle: nil).instantiateViewController(withIdentifier: "TopRatedVC") as! TopRatedVC
        
        let child4 = UIStoryboard.init(name: "UpcomingMovies", bundle: nil).instantiateViewController(withIdentifier: "UpcomingVC") as! UpcomingVC
        
        return [child1, child2 , child3 , child4]
    }
    
}

