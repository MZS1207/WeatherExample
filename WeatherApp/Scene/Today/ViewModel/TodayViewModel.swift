
//
//  TodayViewModel.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

protocol TodayViewModelProtocol {
    var  weatherData     : ((TodayWeatherModel?,Error?)->Void)? {get set}
    var  firebaseData    : ((LocationModel)->Void)?             {get set}
    var  locationManager : CoreLocationManager                  {get}
    func getWeatherData(latitude : Double,longitude : Double)
    func insertLocationToFirebase(latitude : Double,longitude : Double, temperature : Float)
    func getLocationsFromFirebase()
}
class TodayViewModel : TodayViewModelProtocol{
    
    var firebaseData    : ((LocationModel) -> Void)?
    var weatherData     : ((TodayWeatherModel?,Error?) -> Void)?
    let locationManager = CoreLocationManager.shared
    private var firebaseManager : FirebaseLocationManager?
    
    init(){
        firebaseManager = FirebaseLocationManager()
    }
    func getWeatherData(latitude : Double,longitude : Double) {
        let worker = GetWeatherWorker(latitude: latitude,longitude: longitude)
        worker.execute(success: { (weatherModel) in
            self.weather     = weatherModel
        }) { (error) in
            self.weatherError = error
        }
    }
    private var weather :  TodayWeatherModel? {
        didSet{
            weatherData?(weather,nil)
        }
    }
    private var location : LocationModel? {
        didSet{
            guard let _location = location else { return }
            self.firebaseData?(_location)
        }
    }
    private var weatherError : (Error)? {
        didSet {
            weatherData?(nil,weatherError)
        }
    }
}
extension TodayViewModel {
    func insertLocationToFirebase(latitude : Double,longitude : Double, temperature : Float){
        let location = LocationModel(user: LocationModel.User(firstName: "Milos", lastName: "Stevanovic"), location: LocationModel.Coordinate(latitude: latitude, longitude: longitude), temperature: temperature)
        sendLocationToFirebase(location: location)
    }
    private func sendLocationToFirebase(location : LocationModel){
        firebaseManager?.location = location
        firebaseManager?.sendLocation()
    }
    func getLocationsFromFirebase(){
        self.firebaseManager?.getFirebaseLocationData{ [weak self](model) in
            self?.location = model
        }
    }
}
