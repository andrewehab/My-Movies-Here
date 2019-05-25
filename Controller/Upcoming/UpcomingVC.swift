//
//  UpcomingVC.swift
//  My Movies Here
//
//  Created by AnDy on 5/25/19.
//  Copyright © 2019 AnDy. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class UpcomingVC: UIViewController , IndicatorInfoProvider {
    
    
    @IBOutlet weak var upcomingTable: UITableView!
    
    var upcomingMovies : [MovieResults]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        getNowPlayingMovies()
        
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Upcoming")
    }
    
    func getNowPlayingMovies()  {
        NetworkManager.getMovies(target: .upcoming) { (success, error, response) in
            
            if success {
                self.upcomingMovies = response
                self.upcomingTable.reloadData()
            } else {
                print(error.debugDescription)
            }
        }
    }
    
}

extension UpcomingVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell", for: indexPath) as! moviesCell
        
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(upcomingMovies![indexPath.row].backdrop_path ?? " ")")
        cell.movieImage.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let upcomingDetailsVC = storyboard?.instantiateViewController(withIdentifier: "UpcomingDetailsVC") as! UpcomingDetailsVC
        
        upcomingDetailsVC.upcomingDetails = upcomingMovies![indexPath.row]
        navigationController?.pushViewController(upcomingDetailsVC, animated: true)
    }
    
    
}

