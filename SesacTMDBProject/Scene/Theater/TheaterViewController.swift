//
//  TheaterViewController.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/11.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let theater = TheaterList()
    var filteredList: [Theater] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        setUpNavigationBar()

    }
    
    func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showFilterMenu))
    }
    
    @objc func showFilterMenu() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let megabox = UIAlertAction(title: "메가박스", style: .default) { _ in
            
        }
        let lotte = UIAlertAction(title: "롯데시네마", style: .default) { _ in
            
        }
        let cgv = UIAlertAction(title: "CGV", style: .default) { _ in
            
        }
        let all = UIAlertAction(title: "전체보기", style: .default) { _ in
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            
        }
        
        alert.addAction(megabox)
        alert.addAction(lotte)
        alert.addAction(cgv)
        alert.addAction(all)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
