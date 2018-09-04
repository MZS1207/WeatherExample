//
//  CoreLocationManager.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import CoreLocation

protocol CoreLocationManagerProtocol {
    var whenLocationEnable   : (()->Void)? {get set}
    var whenLocationDisable  : (()->Void)? {get set}
    var locationUpdateResult : ((_ locations: [CLLocation]? , _ error : Error? )->Void)? {get set}
}
class CoreLocationManager : NSObject , CoreLocationManagerProtocol{
    
    static let shared     = CoreLocationManager()
    static var coordinate : CLLocationCoordinate2D?
    
    private var locationManager : CLLocationManager!
    private var isAvaiable      = false
    
    var whenLocationEnable      : (()->Void)?
    var whenLocationDisable     : (()->Void)?
    var locationUpdateResult    : (([CLLocation]?, Error?) -> Void)?
    
    override init(){
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    func checkStatus(){
        if CLLocationManager.locationServicesEnabled() {
            let authorizationStatus = CLLocationManager.authorizationStatus()
            switch(authorizationStatus) {
            case .notDetermined, .restricted, .denied:
                locationManager.requestWhenInUseAuthorization()
                isAvaiable = false
                whenLocationDisable?()
            case .authorizedAlways, .authorizedWhenInUse:
                isAvaiable = true
                whenLocationEnable?()
            }
        } else {
            isAvaiable = false
            whenLocationDisable?()
        }
    }
    func setupLocationMonitoring(){
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter  = 100.0
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.activityType = .other
    }
    func startLocationMonitor(){
        setupLocationMonitoring()
        locationManager.startUpdatingLocation()
    }
    func stopLocationMonitor(){
        locationManager.stopUpdatingLocation()
    }
}
extension CoreLocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isAvaiable == false {
            whenLocationEnable?()
            isAvaiable = true
        }
        if let location = locations.last {
                CoreLocationManager.coordinate = location.coordinate
                self.locationUpdateResult?([location],nil)
                self.locationManager.delegate = nil
                self.locationManager.stopUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            isAvaiable = false
            whenLocationDisable?()
        }
        locationUpdateResult?(nil,error)
    }
}
extension CLLocationManager {
    static func authorizedToRequestLocation() -> Bool {
        return CLLocationManager.locationServicesEnabled() &&
            (CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse)
}
}
