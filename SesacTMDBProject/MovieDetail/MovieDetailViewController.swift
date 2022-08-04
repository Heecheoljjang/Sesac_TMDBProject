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
    
    var height: CGFloat = 100
    var isCollapsed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .black
        title = "출연 / 제작"
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.sectionHeaderTopPadding = 32
        
        tableview.register(UINib(nibName: CastTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CastTableViewCell.identifier)
        tableview.register(UINib(nibName: OverviewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OverviewTableViewCell.identifier)
        tableview.register(UINib(nibName: CrewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CrewTableViewCell.identifier)
        
        if let data = movieData {
            print("data:\(data)")
            setUpHeaderView(data: data)
        }
        
        fetchCast()
        
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
                
                for cast in json["cast"].arrayValue {
                    let profileImageURL = cast["profile_path"].stringValue
                    let name = cast["name"].stringValue
                    let department = cast["known_for_department"].stringValue
                    
                    self.castList.append(CastModel(name: name, profileURL: profileImageURL, department: department))
                }
                
                for crew in json["crew"].arrayValue {
                    let name = crew["name"].stringValue
                    let department = crew["known_for_department"].stringValue
                    
                    self.crewList.append(CrewModel(name: name, department: department))
                }
                self.tableview.reloadData()
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
        if section == 0 {
            return 1
        } else if section == 1 {
            return castList.count
        } else {
            return crewList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableview.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell() }
            
            cell.overviewLabel.text = movieData?.overview
            cell.overviewLabel.numberOfLines = isCollapsed ? 2 : 0
            cell.moreButton.setImage(UIImage(systemName: isCollapsed ? "chevron.down" : "chevron.up"), for: .normal)
            
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableview.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
            
            cell.nameLabel.text = castList[indexPath.item].name
            cell.departmentLabel.text = castList[indexPath.item].department
            
            let url = URL(string: EndPoint.imageURL + castList[indexPath.item].profileURL)
            cell.profileImageView.kf.setImage(with: url)
            
            return cell
        } else {
            guard let cell = tableview.dequeueReusableCell(withIdentifier: CrewTableViewCell.identifier) as? CrewTableViewCell else { return UITableViewCell() }
            
            cell.nameLabel.text = crewList[indexPath.item].name
            cell.departmentLabel.text = crewList[indexPath.item].department
            
            return cell
        }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            isCollapsed = !isCollapsed
            
            height = isCollapsed ? 120 : UITableView.automaticDimension
            
            tableview.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return height
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Overview"
        } else if section == 1 {
            return "Cast"
        } else {
            return "Crew"
        }
    }

}
