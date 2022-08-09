//
//  NetflixViewController.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/09.
//

import UIKit

class NetflixViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    let titleList = ["아는 와이프와 비슷한 컨텐츠","액션","가족","미국 TV 프로그램","미스터 션샤인과 비슷한 컨텐츠"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.register(UINib(nibName: "ReuseTableViewCell", bundle: nil), forCellReuseIdentifier: "ReuseTableViewCell")
        movieTableView.backgroundColor = .black
    }
}

extension NetflixViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = movieTableView.dequeueReusableCell(withIdentifier: "ReuseTableViewCell", for: indexPath) as? ReuseTableViewCell else { return UITableViewCell() }
        
        cell.sectionLabel.text = titleList[indexPath.row]
        cell.movieCollectionView.delegate = self
        cell.movieCollectionView.dataSource = self
        cell.movieCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        cell.movieCollectionView.reloadData()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

extension NetflixViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        
        return cell
    }
    
}
