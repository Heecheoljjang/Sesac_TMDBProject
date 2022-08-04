//
//  CastTableViewCell.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/04.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        setUpUI()
    }
    
    func setUpUI() {
        departmentLabel.font = .systemFont(ofSize: 14, weight: .regular)
        departmentLabel.textColor = .lightGray
        profileImageView.layer.cornerRadius = 10
        profileImageView.contentMode = .scaleToFill
    }
    
}
