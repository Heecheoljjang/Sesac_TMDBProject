//
//  ViewController.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/03.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class TMDBViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieList: [TMDBModel] = []
    var page = 1
    var genreDic: [Int: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        fetchMovieData(page: page)
        fetchGenre()
        
        collectionView.register(UINib(nibName: TMDBCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TMDBCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        
        let width = view.frame.size.width - (2 * spacing)
        
        layout.itemSize = CGSize(width: width, height: width * 1.15)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: 0, bottom: spacing, right: 0)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        collectionView.collectionViewLayout = layout
        
        navigationItem.backButtonTitle = ""
    }

    
    func fetchMovieData(page: Int) {
        
        let url = EndPoint.tmdbURL + APIKey.TMDB_KEY + "&page=\(page)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                for movie in json["results"].arrayValue {
                    let originalTitle = movie["original_title"].stringValue
                    let releaseDate = movie["release_date"].stringValue
                    let rate = movie["vote_average"].doubleValue
                    let imageURL = movie["backdrop_path"].stringValue
                    let overview = movie["overview"].stringValue
                    let movieId = movie["id"].intValue
                    let posterURL = movie["poster_path"].stringValue
                    let genreId = movie["genre_ids"][0].intValue
                    
                    let data = TMDBModel(title: originalTitle, releaseDate: releaseDate, rate: rate, imageURL: imageURL, overview: overview, movieId: movieId, posterURL: posterURL, genre: genreId)
                    
                    self.movieList.append(data)
                }
                self.collectionView.reloadData()
                print(self.movieList.count)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchGenre() {
        
        let url = EndPoint.genreURL + APIKey.TMDB_KEY
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                for genre in json["genres"].arrayValue {
                    self.genreDic[genre["id"].intValue] = genre["name"].stringValue
                }
                print(self.genreDic)
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TMDBViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if movieList.count - 1 == indexPath.item {
                page += 1
                fetchMovieData(page: page)
            }
        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//        <#code#>
//    }
}

extension TMDBViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMDBCollectionViewCell.identifier, for: indexPath) as? TMDBCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: EndPoint.imageURL + movieList[indexPath.item].imageURL)
        cell.posterImageView.kf.setImage(with: url)
        cell.titleLabel.text = movieList[indexPath.item].title
        cell.realRate.text = "\(round(movieList[indexPath.item].rate * 10) / 10 )"
        cell.genreLabel.text = "#\(genreDic[movieList[indexPath.item].genre] ?? "Sesac")"
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let temp = format.date(from: movieList[indexPath.item].releaseDate)
        format.dateFormat = "MM/dd/yyyy"
        let newDate = format.string(from: temp!)
        
        cell.releaseLabel.text = newDate
        cell.actorLabel.text = movieList[indexPath.item].overview
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "MovieDetail", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: MovieDetailViewController.identifier) as? MovieDetailViewController else { return }
        vc.movieData = TMDBModel(title: movieList[indexPath.item].title, releaseDate: movieList[indexPath.item].releaseDate, rate: round(movieList[indexPath.item].rate * 10) / 10, imageURL: EndPoint.imageURL + movieList[indexPath.item].imageURL, overview: movieList[indexPath.item].overview, movieId: movieList[indexPath.item].movieId, posterURL: EndPoint.imageURL + movieList[indexPath.item].posterURL, genre: movieList[indexPath.item].genre)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
