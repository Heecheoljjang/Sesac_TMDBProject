//
//  MovieDetailViewController.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/04.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var movieData: TMDBModel?
    var castList: [CastModel] = []
    var crewList: [CrewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .black
        title = "출연 / 제작"
        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(UINib(nibName: CastTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CastTableViewCell.identifier)
        tableview.register(UINib(nibName: OverviewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OverviewTableViewCell.identifier)
        tableview.register(UINib(nibName: CrewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CrewTableViewCell.identifier)
        
        if let data = movieData {
            print("data:\(data)")
            setUpHeaderView(data: data)
        }
        
        fetchCast()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func setUpHeaderView(data: TMDBModel) {
        let backImageURL = URL(string: data.imageURL)
        let posterImageURL = URL(string: data.posterURL)
        backImageView.contentMode = .scaleAspectFill
        backImageView.kf.setImage(with: backImageURL)
        titleLabel.text = data.title
        titleLabel.font = .systemFont(ofSize: 22, weight: .heavy)
        titleLabel.textColor = .white
        posterImageView.kf.setImage(with: posterImageURL)
    }
    
    func fetchCast() {
        
        guard let movieData = movieData else {
            return
        }
        
        let url = EndPoint.castURL + "\(movieData.movieId)" + EndPoint.castCreditURL + APIKey.TMDB_KEY
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableview.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell() }
            
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableview.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
            
            return cell
        } else {
            guard let cell = tableview.dequeueReusableCell(withIdentifier: CrewTableViewCell.identifier) as? CrewTableViewCell else { return UITableViewCell() }
            
            return cell
        }
        
    }
    
}
