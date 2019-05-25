//
//  TopRatedVC.swift
//  My Cinema Movies
//
//  Created by AnDy on 5/23/19.
//  Copyright © 2019 AnDy. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TopRatedVC: UIViewController , IndicatorInfoProvider {

    @IBOutlet weak var topRatedTable: UITableView!
    
    var topRatedMovies : [MovieResults]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        getNowPlayingMovies()
        
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Top Rated")
    }
    
    func getNowPlayingMovies()  {
        NetworkManager.getMovies(target: .topRated) { (success, error, response) in
            
            if success {
                self.topRatedMovies = response
                self.topRatedTable.reloadData()
            } else {
                print(error.debugDescription)
            }
        }
    }
    
}

extension TopRatedVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topRatedMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "topRatedCell", for: indexPath) as! moviesCell
        
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(topRatedMovies![indexPath.row].backdrop_path ?? " ")")
        cell.movieImage.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let topRatedDetailsVC = storyboard?.instantiateViewController(withIdentifier: "TopRatedDetailsVC") as! TopRatedDetailsVC
        
        topRatedDetailsVC.topRatedDetails = topRatedMovies![indexPath.row]
        navigationController?.pushViewController(topRatedDetailsVC, animated: true)
    }
    
    
}

