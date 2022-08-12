//
//  TheaterViewController.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/11.
//

import UIKit
import MapKit
//import CoreLocation

class TheaterViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let theater = TheaterList()
    var coordinateList: [CLLocationCoordinate2D] = []
    var center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270) //새싹
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        setUpNavigationBar()
                
        locationManager.delegate = self

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

extension TheaterViewController {
    
    //버전체크 및 권한 체크
    func checkUserDeviceLocationServiceAuthorization() {
        let autorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            autorizationStatus = locationManager.authorizationStatus
        } else {
            autorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        //위치서비스 활성화체크
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(autorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있습니다.")
        }
    }
    
    // 사용자의 위치 권한 상태 확인
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("위치 권한을 허용해주세요.")
            showRequestLocationServiceAlert()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            print("default")
        }
    }
    func showRequestLocationServiceAlert() {
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
          
          //설정페이지로 가는링크
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }
          
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}

extension TheaterViewController: CLLocationManagerDelegate {
    
    //사용자의 위치를 성공적으로 가져왔는지.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        
        if let center = locations.last?.coordinate {
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.center = center
            setRegion(center: center)
            setAnnotation(center: center, theaterLocation: theater.mapAnnotations)
        }
        locationManager.stopUpdatingLocation()
    }
    
    //성공적으로 가져오지 못했는지
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
    
}
