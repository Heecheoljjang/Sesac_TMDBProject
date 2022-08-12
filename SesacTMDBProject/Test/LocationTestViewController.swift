//
//  LocationTestViewController.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/12.
//

import UIKit
import CoreLocation
import PhotosUI

class LocationTestViewController: UIViewController {

    let locationManager = CLLocationManager()
    var configuration = PHPickerConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
    }

}

extension LocationTestViewController: CLLocationManagerDelegate {
    
}
