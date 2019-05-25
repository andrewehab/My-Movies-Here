//
//  Movies_API.swift
//  My Cinema Movies
//
//  Created by AnDy on 5/23/19.
//  Copyright © 2019 AnDy. All rights reserved.
//

import Foundation
import Moya

enum MoviesAPI {
    
    static private let apiKey = "b25c9ab891a107dd4442fff5e44409de"
    
    case nowPlaying
    case popular
    case topRated
    case upcoming
}

extension MoviesAPI : TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/") else {
            fatalError("Can't Configured Base URL")
        }
        return url
    }
    
    var path: String {
        
        switch self {
            
        case .nowPlaying:
            return("now_playing")
            
        case .popular:
            return("popular")
            
        case .topRated:
            return("top_rated")
            
        case .upcoming:
            return("upcoming")
            
        }
    }
    
    var method: Moya.Method {
        
        return .get
    }
    
    var sampleData: Data {
        
        return Data()
    }
    
    var parameters : [String : Any] {
        
        return ["api_key" : MoviesAPI.apiKey]
    }
    
    var task: Task {
        
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        
        return ["content-type" : "application/json"]
    }
    
    var validationType: ValidationType{
        
        return .successCodes
    }
    
}
