//
//  ReuseTableViewCell.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/09.
//

import UIKit

class ReuseTableViewCell: UITableViewCell {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var sectionLabel: UILabel!
    
    override func awakeFromNib() {
        setUpUI()
    }
    
    func setUpUI() {
        movieCollectionView.backgroundColor = .blue
        sectionLabel.font = .boldSystemFont(ofSize: 22)
        movieCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: movieCollectionView.frame.size.height * 0.8, height: movieCollectionView.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        return layout
    }
}
