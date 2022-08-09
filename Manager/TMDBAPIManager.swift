//
//  TMDBAPIManager.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/06.
//

import Foundation

import Alamofire
import SwiftyJSON

class FetchMovieDataAPIManager {
    
    //인스턴스 생성하지 못하게
    private init() {}
    
    //Singleton
    static let shared = FetchMovieDataAPIManager()
    
    func fetchMovieData(page: Int, completionHandler: @escaping ([TMDBModel]) -> ()) {
        
        let url = EndPoint.tmdbURL + APIKey.TMDB_KEY + "&page=\(page)"
        AF.request(url, method: .get).validate().responseJSON(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print(json)

                let list = json["results"].arrayValue.map { TMDBModel(title: $0["original_title"].stringValue, releaseDate: $0["release_date"].stringValue, rate: $0["vote_average"].doubleValue, imageURL: $0["backdrop_path"].stringValue, overview: $0["overview"].stringValue, movieId: $0["id"].intValue, posterURL: $0["poster_path"].stringValue, genre: $0["genre_ids"][0].intValue)}
                
                completionHandler(list)

            case .failure(let error):
                print(error)
            }
        }
    }
}

class FetchGenreAPIManager {
    private init() {}
    
    static let shared = FetchGenreAPIManager()
    
    func fetchGenre(completionHandler: @escaping ([Int: String]) -> ()) {
        
        let url = EndPoint.genreURL + APIKey.TMDB_KEY
        
        AF.request(url, method: .get).validate().responseJSON(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var genreDic: [Int: String] = [:]
                let list = json["genres"].arrayValue.map {genreDic[$0["id"].intValue] = $0["name"].stringValue}
                
                completionHandler(genreDic)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

class FetchTrailerLinkAPIManager {
    
    private init() {}
    
    static let shared = FetchTrailerLinkAPIManager()
    
    func fetchTrailerLink(movieId: Int, completionHandler: @escaping (String) -> ()) {
        
        let url = EndPoint.trailerURL + "\(movieId)" + EndPoint.trailerVideoURL + APIKey.TMDB_KEY
        
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                completionHandler(json["results"][0]["key"].stringValue)

            case .failure(let error):
                print(error)
            }
        }
        
    }
}

class FetchCastAPIManager {
    private init() {}
    
    static let shared = FetchCastAPIManager()
    
    func fetchCast(movieData: TMDBModel, completionHandler: @escaping ([CastModel], [CrewModel]) -> ()) {
        
        let url = EndPoint.castURL + "\(movieData.movieId)" + EndPoint.castCreditURL + APIKey.TMDB_KEY
        
        AF.request(url, method: .get).validate().responseJSON(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let cast = json["cast"].arrayValue.map { CastModel(name: $0["name"].stringValue, profileURL: $0["profile_path"].stringValue, department: $0["known_for_department"].stringValue) }
                let crew = json["crew"].arrayValue.map { CrewModel(name: $0["name"].stringValue, department: $0["known_for_department"].stringValue) }
                
                completionHandler(cast, crew)
            case .failure(let error):
                print(error)
            }
        }
    }
}
