//
//  VideoViewController.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/05.
//

import UIKit
import WebKit

import Alamofire
import SwiftyJSON

class VideoViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var movieId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        
        fetchTrailerLink(movieId: movieId)
        
    }
    
    func openTrailerURL(url: String) {
        
    }
    
    func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissWebView))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func fetchTrailerLink(movieId: Int) {
        
        let url = EndPoint.trailerURL + "\(movieId)" + EndPoint.trailerVideoURL + APIKey.TMDB_KEY
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
