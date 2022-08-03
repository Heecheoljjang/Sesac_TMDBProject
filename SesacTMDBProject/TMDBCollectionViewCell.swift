//
//  TMDBCollectionViewCell.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/03.
//

import UIKit

class TMDBCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: TMDBCollectionViewCell.self)

    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var realRate: UILabel!
    @IBOutlet weak var rateLabelView: UIView!
    @IBOutlet weak var realRateLabelView: UIView!
    
    override func awakeFromNib() {
        setUpCell()
    }
    
    func setUpCell() {
        releaseLabel.font = .systemFont(ofSize: 13)
        releaseLabel.textColor = .lightGray
        genreLabel.text = "#Sesac"
        genreLabel.font = .boldSystemFont(ofSize: 20)
        outerView.layer.cornerRadius = 10
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 0.3
        outerView.layer.shadowRadius = 10
        posterImageView.layer.cornerRadius = 10
        posterImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        posterImageView.contentMode = .scaleAspectFill
        actorLabel.font = .systemFont(ofSize: 13)
        actorLabel.textColor = .lightGray
        detailLabel.text = "자세히 보기"
        detailLabel.font = .systemFont(ofSize: 13)
        rateLabel.adjustsFontSizeToFitWidth = true
        rateLabel.textColor = .white
        rateLabel.text = "평점"
        rateLabelView.backgroundColor = .systemIndigo
        realRate.adjustsFontSizeToFitWidth = true

    }
}
