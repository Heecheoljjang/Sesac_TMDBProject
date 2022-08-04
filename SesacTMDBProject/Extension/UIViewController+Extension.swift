//
//  UIViewController+Extension.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/04.
//

import Foundation
import UIKit

extension UIViewController: ReuseIdentifier {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
