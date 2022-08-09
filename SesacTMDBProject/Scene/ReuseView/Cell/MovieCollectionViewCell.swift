//
//  MovieCollectionViewCell.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/09.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
        
    }

    func setUpUI() {
        movieView.backgroundColor = .orange
    }
}
