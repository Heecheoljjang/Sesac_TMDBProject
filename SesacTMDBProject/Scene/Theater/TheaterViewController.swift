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
    var coordinateList: [CLLocationCoordinate2D] = []
    var center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        setUpNavigationBar()
        
        //새싹 좌표: 37.517829, 126.886270
        
        locationManager.delegate = self
        
        //coordinateList = theater.mapAnnotations.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }
        
        setRegion(center: center)
        setAnnotation(center: center, theaterLocation: theater.mapAnnotations)
        

    }
    
    func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showFilterMenu))
    }
    
    @objc func showFilterMenu() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let megabox = UIAlertAction(title: "메가박스", style: .default) { value in
            guard let type = value.title else { return }

            self.mapView.removeAnnotations(self.mapView.annotations)
            
            self.setAnnotation(center: self.center, theaterLocation: self.theater.mapAnnotations.filter { $0.type == type})
        }
        let lotte = UIAlertAction(title: "롯데시네마", style: .default) { value in
            guard let type = value.title else { return }

            self.mapView.removeAnnotations(self.mapView.annotations)
            
            self.setAnnotation(center: self.center, theaterLocation: self.theater.mapAnnotations.filter { $0.type == type})
        }
        let cgv = UIAlertAction(title: "CGV", style: .default) { value in
            guard let type = value.title else { return }

            self.mapView.removeAnnotations(self.mapView.annotations)
            
            self.setAnnotation(center: self.center, theaterLocation: self.theater.mapAnnotations.filter { $0.type == type})
        }
        let all = UIAlertAction(title: "전체보기", style: .default) { value in
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            self.setAnnotation(center: self.center, theaterLocation: self.theater.mapAnnotations)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(megabox)
        alert.addAction(lotte)
        alert.addAction(cgv)
        alert.addAction(all)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func setRegion(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 3000, longitudinalMeters: 3000)
        mapView.setRegion(region, animated: true)
    }
    
    func setAnnotation(center: CLLocationCoordinate2D, theaterLocation: [Theater]) {
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
