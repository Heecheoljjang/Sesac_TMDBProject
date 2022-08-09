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
        
        sectionLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        sectionLabel.backgroundColor = .black
        sectionLabel.textColor = .white
        backgroundColor = .black
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.frame.size.height * 0.6, height: 300)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        return layout
    }
}
