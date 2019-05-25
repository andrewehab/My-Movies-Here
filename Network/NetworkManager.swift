//
//  NetworkManager.swift
//  My Cinema Movies
//
//  Created by AnDy on 5/23/19.
//  Copyright © 2019 AnDy. All rights reserved.
//

import Foundation
import Moya
class NetworkManager {
    
    
    static private let provider = MoyaProvider<MoviesAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    static private let jsonDecoder = JSONDecoder()
    
    // MARK:- Get Now playing Movies
    
    
    static func getMovies (target : MoviesAPI , completion : @escaping(_ success : Bool , _ error : Error? ,_ nowplayingModel : [MovieResults]?)->Void) {
        
        provider.request(target) { (response) in
            
            switch response.result {
                
            case .success(let value) :
                do {
                    let responseModel = try jsonDecoder.decode(MoviesModel.self, from: value.data).results
                    completion (true , nil ,responseModel)
                } catch(let error ){
                    completion(false , error , nil)
                }
            case .failure(let error):
                completion(false , error , nil)
            }
        }
        
    }
}
