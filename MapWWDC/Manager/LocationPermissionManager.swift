//
//  LocalPermissionManager.swift
//  MapWWDC
//
//  Created by MaToSens on 10/06/2023.
//

import Foundation
import CoreLocation

class LocationPermissionManager: NSObject {

    var userCoordinate: ((CLLocationCoordinate2D) -> Void)?
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = 10
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        
        
        return manager
    }()
    
    override init() {
        super.init()
        requestPermissionToAccessLocation()
    }
    
    func requestPermissionToAccessLocation() {
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
}


extension LocationPermissionManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
}
