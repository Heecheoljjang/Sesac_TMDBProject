//
//  CrewTableViewCell.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/04.
//

import UIKit

class CrewTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    
    override func awakeFromNib() {
        departmentLabel.textColor = .lightGray
        departmentLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
}
