//
//  NowPlayingVC.swift
//  My Cinema Movies
//
//  Created by AnDy on 5/23/19.
//  Copyright © 2019 AnDy. All rights reserved.
//

import UIKit
import Kingfisher
import XLPagerTabStrip

class NowPlayingVC: UIViewController ,IndicatorInfoProvider {
    
    @IBOutlet weak var nowPlayingTable: UITableView!
    
    var nowPlayingMovies : [MovieResults]?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        getNowPlayingMovies()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Now Playing")
    }
    
    
    func getNowPlayingMovies()  {
        NetworkManager.getMovies(target: .nowPlaying) { (success, error, response) in
            
            if success {
                self.nowPlayingMovies = response
                self.nowPlayingTable.reloadData()
            } else {
                print(error.debugDescription)
            }
        }
    }
    
    
    
}


extension NowPlayingVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nowPlayingMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "nowPlayingCell", for: indexPath) as! moviesCell
        
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(nowPlayingMovies![indexPath.row].poster_path ?? " ")")
        cell.movieImage.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nowPlayingDetailsVC = storyboard?.instantiateViewController(withIdentifier: "NowplayingDetailsVC") as! NowplayingDetailsVC
        
        nowPlayingDetailsVC.nowPlayingDetails = nowPlayingMovies![indexPath.row]
        navigationController?.pushViewController(nowPlayingDetailsVC, animated: true)
    }
    
    
}

