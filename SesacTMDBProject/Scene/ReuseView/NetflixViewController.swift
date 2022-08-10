//
//  NetflixViewController.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/09.
//

import UIKit

import Kingfisher

class NetflixViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    let titleList = ["아는 와이프와 비슷한 컨텐츠","액션","가족","미국 TV 프로그램","미스터 션샤인과 비슷한 컨텐츠"]
    var recommendation: [String: [String]] = [:]
    var keys : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.register(UINib(nibName: "ReuseTableViewCell", bundle: nil), forCellReuseIdentifier: "ReuseTableViewCell")
        movieTableView.backgroundColor = .black
        
        //받아와서 6개만 돌려보기
        FetchMovieDataAPIManager.shared.fetchRecommendationPoster { value in
            self.recommendation = value
            print(self.recommendation)
            self.keys = self.recommendation.keys.sorted(by: <).filter { self.recommendation[$0]?.count != 0 }
            self.movieTableView.reloadData()
        }
        
    }
}

extension NetflixViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = movieTableView.dequeueReusableCell(withIdentifier: "ReuseTableViewCell", for: indexPath) as? ReuseTableViewCell else { return UITableViewCell() }
        
        cell.sectionLabel.text = keys[indexPath.row] + "와 비슷한 컨텐츠"
        cell.sectionLabel.adjustsFontSizeToFitWidth = true
        cell.movieCollectionView.delegate = self
        cell.movieCollectionView.dataSource = self
        cell.movieCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        cell.movieCollectionView.tag = indexPath.row
        cell.movieCollectionView.reloadData()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 250

    }
}

extension NetflixViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendation[keys[collectionView.tag]]!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: recommendation[keys[collectionView.tag]]![indexPath.item])
        cell.movieView.posterImageView.kf.setImage(with: url)
        
        return cell
    }
    
}
