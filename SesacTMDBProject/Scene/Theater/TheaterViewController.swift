//
//  TheaterViewController.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/11.
//

import UIKit
import MapKit
import CoreLocation

class TheaterViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let theater = TheaterList()
    var filteredList: [Theater] = []
    var locationList: [CLLocationCoordinate2D] = []
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        setUpNavigationBar()
        
        //새싹 좌표: 37.517829, 126.886270
        
        locationManager.delegate = self
        
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        locationList = theater.mapAnnotations.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }

        setRegionAndAnnotation(center: center, theaterLocation: theater.mapAnnotations)
        
        

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
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D, theaterLocation: [Theater]) {
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 3000, longitudinalMeters: 3000)
        mapView.setRegion(region, animated: true)
        
        let centerAnnotation = MKPointAnnotation()
        centerAnnotation.title = "현재 위치"
        centerAnnotation.coordinate = center
        
        var tempList: [MKPointAnnotation] = []
        for location in theaterLocation {
            let annotation = MKPointAnnotation()
            annotation.title = "\(location.location)"
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            tempList.append(annotation)
        }
        mapView.addAnnotation(centerAnnotation)
        mapView.addAnnotations(tempList)
        
    }
}

extension TheaterViewController: CLLocationManagerDelegate {
    
    
}
