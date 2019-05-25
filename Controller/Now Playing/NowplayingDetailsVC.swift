//
//  NowplayingDetailsVC.swift
//  My Cinema Movies
//
//  Created by AnDy on 5/23/19.
//  Copyright © 2019 AnDy. All rights reserved.
//

import UIKit
import Kingfisher

class NowplayingDetailsVC: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    var nowPlayingDetails : MovieResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // change color of title bar
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        updateViews()
    }
    
    
    func updateViews() {
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(nowPlayingDetails!.backdrop_path ?? " ")")
        
        movieImage.kf.setImage(with: url)
        movieName.text = nowPlayingDetails?.title
        movieOverview.text = nowPlayingDetails?.overview
        movieDate.text = " Released at : \(nowPlayingDetails?.release_date ?? " ")"
        let myLang = nowPlayingDetails?.original_language == "en" ? "English" : "Unknown"
        movieLanguage.text = myLang
        let rating  = ((nowPlayingDetails?.vote_average)! as NSNumber).doubleValue
        movieRating.text = "Rating : \(String(rating))"
    }
}
