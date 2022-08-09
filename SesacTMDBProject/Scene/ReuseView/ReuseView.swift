//
//  ReuseView.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/09.
//

import UIKit

class ReuseView: UIView {

    @IBOutlet weak var posterImageView: UIImageView!
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        loadView()
    }
    
    func loadView() {
        let view = UINib(nibName: "ReuseView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .green
//        posterImageView.layer.cornerRadius = 10
//        posterImageView.backgroundColor = .blue
        self.addSubview(view)
    }
}
