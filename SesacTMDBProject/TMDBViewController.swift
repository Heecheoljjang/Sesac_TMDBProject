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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        fetchMovieData()
        
        collectionView.register(UINib(nibName: TMDBCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TMDBCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        
        let width = view.frame.size.width - (2 * spacing)
        
        layout.itemSize = CGSize(width: width, height: width * 1.15)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: 0, bottom: spacing, right: 0)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        collectionView.collectionViewLayout = layout
        
    }

    
    func fetchMovieData() {
        
        let url = EndPoint.tmdbURL + APIKey.TMDB_KEY
        
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
                    
                    let data = TMDBModel(title: originalTitle, releaseDate: releaseDate, rate: rate, imageURL: imageURL, overview: overview)
                    
                    self.movieList.append(data)
                }
                self.collectionView.reloadData()
                print(self.movieList.count)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

extension TMDBViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMDBCollectionViewCell.identifier, for: indexPath) as? TMDBCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: "http://image.tmdb.org/t/p/w500" + movieList[indexPath.item].imageURL)
        cell.posterImageView.kf.setImage(with: url)
        cell.titleLabel.text = movieList[indexPath.item].title
        cell.realRate.text = "\(round(movieList[indexPath.item].rate * 10) / 10 )"
        cell.releaseLabel.text = movieList[indexPath.item].releaseDate
        cell.actorLabel.text = movieList[indexPath.item].overview
        
        return cell
    }
    
    

}
