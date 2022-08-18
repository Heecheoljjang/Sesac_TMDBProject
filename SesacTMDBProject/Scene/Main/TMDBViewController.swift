//
//  ViewController.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/03.
//

import UIKit
import UIFramework

import Alamofire
import SwiftyJSON
import Kingfisher
import JGProgressHUD

class TMDBViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieList: [TMDBModel] = []
    var page = 1
    var genreDic: [Int: String] = [:]
    var trailerKey: String = ""
    
    var movieDetailHandler: ((TMDBModel) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 네트워킹
        fetchMovieData(page: page)
        
        fetchGenre()
        
        //컬렉션뷰
        setUpCollectionView()
        
        navigationItem.backButtonTitle = ""
    }
    
    func setUpCollectionView() {
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
    }

    func fetchMovieData(page: Int) {
        FetchMovieDataAPIManager.shared.fetchMovieData(page: page) { list in
            self.movieList.append(contentsOf: list)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func fetchGenre() {
        FetchGenreAPIManager.shared.fetchGenre { genreDic in
            self.genreDic = genreDic
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    func fetchTrailerLink(movieId: Int) {
        FetchTrailerLinkAPIManager.shared.fetchTrailerLink(movieId: movieId) { trailerKey in
            self.trailerKey = trailerKey
            DispatchQueue.main.async {
                let sb = UIStoryboard(name: "VideoView", bundle: nil)
                guard let vc = sb.instantiateViewController(withIdentifier: VideoViewController.reuseIdentifier) as? VideoViewController else { return }
                vc.trailerKey = self.trailerKey
                let naviationController = UINavigationController(rootViewController: vc)
                naviationController.modalPresentationStyle = .fullScreen
                self.present(naviationController, animated: true)
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
        
        // tag설정
        cell.linkButton.tag = indexPath.item
        
        cell.linkButton.addTarget(self, action: #selector(showVideo(sender: )), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "MovieDetail", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: MovieDetailViewController.reuseIdentifier) as? MovieDetailViewController else { return }
//        vc.movieData = TMDBModel(title: movieList[indexPath.item].title, releaseDate: movieList[indexPath.item].releaseDate, rate: round(movieList[indexPath.item].rate * 10) / 10, imageURL: EndPoint.imageURL + movieList[indexPath.item].imageURL, overview: movieList[indexPath.item].overview, movieId: movieList[indexPath.item].movieId, posterURL: EndPoint.imageURL + movieList[indexPath.item].posterURL, genre: movieList[indexPath.item].genre)
        
        movieDetailHandler = { data in
            vc.movieData = data
        }
        
        movieDetailHandler?(TMDBModel(title: movieList[indexPath.item].title, releaseDate: movieList[indexPath.item].releaseDate, rate: round(movieList[indexPath.item].rate * 10) / 10, imageURL: EndPoint.imageURL + movieList[indexPath.item].imageURL, overview: movieList[indexPath.item].overview, movieId: movieList[indexPath.item].movieId, posterURL: EndPoint.imageURL + movieList[indexPath.item].posterURL, genre: movieList[indexPath.item].genre))
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
