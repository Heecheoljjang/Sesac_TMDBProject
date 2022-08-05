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
    
    var trailerKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(trailerKey)
        setUpNavigationBar()
        print(#function)
        openTrailerURL(key: trailerKey)
        
    }
    
    func openTrailerURL(key: String) {
        
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(key)") else { return }
        
        print(url)
        
        let request = URLRequest(url: url)
        
        webView.load(request)
        print(#function)
    }
    
    func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissWebView))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
}
