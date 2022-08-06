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
        print("123",Thread.isMainThread)
        
        AF.request(url, method: .get).validate().responseJSON { response in
            print("456", Thread.isMainThread)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
//                for movie in json["results"].arrayValue {
//                    let originalTitle = movie["original_title"].stringValue
//                    let releaseDate = movie["release_date"].stringValue
//                    let rate = movie["vote_average"].doubleValue
//                    let imageURL = movie["backdrop_path"].stringValue
//                    let overview = movie["overview"].stringValue
//                    let movieId = movie["id"].intValue
//                    let posterURL = movie["poster_path"].stringValue
//                    let genreId = movie["genre_ids"][0].intValue
//
//                    let data = TMDBModel(title: originalTitle, releaseDate: releaseDate, rate: rate, imageURL: imageURL, overview: overview, movieId: movieId, posterURL: posterURL, genre: genreId)
//                }
                
                let list = json["results"].arrayValue.map { TMDBModel(title: $0["original_title"].stringValue, releaseDate: $0["release_date"].stringValue, rate: $0["vote_average"].doubleValue, imageURL: $0["backdrop_path"].stringValue, overview: $0["overview"].stringValue, movieId: $0["id"].intValue, posterURL: $0["poster_path"].stringValue, genre: $0["genre_ids"][0].intValue)}
                
                completionHandler(list)
//                self.collectionView.reloadData()
//                print(self.movieList.count)
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
                
//                for genre in json["genres"].arrayValue {
//                    self.genreDic[genre["id"].intValue] = genre["name"].stringValue
//                }
//                self.collectionView.reloadData()
                
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
                
//                for cast in json["cast"].arrayValue {
//                    let profileImageURL = cast["profile_path"].stringValue
//                    let name = cast["name"].stringValue
//                    let department = cast["known_for_department"].stringValue
//
//                    self.castList.append(CastModel(name: name, profileURL: profileImageURL, department: department))
//                }
//
//                for crew in json["crew"].arrayValue {
//                    let name = crew["name"].stringValue
//                    let department = crew["known_for_department"].stringValue
//
//                    self.crewList.append(CrewModel(name: name, department: department))
//                }
                
                let cast = json["cast"].arrayValue.map { CastModel(name: $0["name"].stringValue, profileURL: $0["profile_path"].stringValue, department: $0["known_for_department"].stringValue) }
                let crew = json["crew"].arrayValue.map { CrewModel(name: $0["name"].stringValue, department: $0["known_for_department"].stringValue) }
                //self.tableview.reloadData()
                
                completionHandler(cast, crew)
            case .failure(let error):
                print(error)
            }
        }
    }
}
