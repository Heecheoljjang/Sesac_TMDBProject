//
//  MovieCollectionViewCell.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/10.
//
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieView: ReuseView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
        
        
    }

    func setUpUI() {
        movieView.backgroundColor = .clear
        movieView.posterImageView.layer.cornerRadius = 10
        movieView.posterImageView.backgroundColor = .clear
        
    }
}

