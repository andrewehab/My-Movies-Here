//
//  PopularVC.swift
//  My Cinema Movies
//
//  Created by AnDy on 5/23/19.
//  Copyright © 2019 AnDy. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PopularVC: UIViewController  , IndicatorInfoProvider {
    
    @IBOutlet weak var popularTable: UITableView!
    
    var popularMovies : [MovieResults]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        getNowPlayingMovies()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Popular")

    }
    
    func getNowPlayingMovies()  {
        NetworkManager.getMovies(target: .popular) { (success, error, response) in
            
            if success {
                self.popularMovies = response
                self.popularTable.reloadData()
            } else {
                print(error.debugDescription)
            }
        }
    }
    
}

extension PopularVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! moviesCell
        
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(popularMovies![indexPath.row].backdrop_path ?? " ")")
        cell.movieImage.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let popularDetailsVC = storyboard?.instantiateViewController(withIdentifier: "PopularDetailsVC") as! PopularDetailsVC
        
        popularDetailsVC.popularDetails = popularMovies![indexPath.row]
        navigationController?.pushViewController(popularDetailsVC, animated: true)
    }
    
    
}

