//
//  UIViewController+Extension.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/04.
//

import Foundation
import UIKit

import Alamofire
import SwiftyJSON
import JGProgressHUD

extension UIViewController: ReuseIdentifier {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
   
    @objc func dismissWebView() {
        self.dismiss(animated: true)
    }
    
}

extension TMDBViewController {
    
    @objc func showVideo(sender: UIButton) {
        
        //네트워킹
        fetchTrailerLink(movieId: movieList[sender.tag].movieId) { key in
            let sb = UIStoryboard(name: "VideoView", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: VideoViewController.identifier) as? VideoViewController else { return }
            vc.trailerKey = key
            let naviationController = UINavigationController(rootViewController: vc)
            naviationController.modalPresentationStyle = .fullScreen
            self.present(naviationController, animated: true)
        }
    }
    
}
