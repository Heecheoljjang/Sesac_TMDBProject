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
        super.awakeFromNib()
        
        setUpUI()
    }
    
    func setUpUI() {
        movieCollectionView.backgroundColor = .black
        movieCollectionView.collectionViewLayout = collectionViewLayout()
        
        sectionLabel.font = .systemFont(ofSize: 18, weight: .bold)
        sectionLabel.backgroundColor = .black
        sectionLabel.textColor = .white
        backgroundColor = .black
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        layout.minimumLineSpacing = 0
        
        return layout
    }
}
