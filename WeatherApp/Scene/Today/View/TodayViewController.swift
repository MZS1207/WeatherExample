
//
//  TodayViewController.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/25/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import UIKit
import CoreLocation

class TodayViewController: BaseViewController {
    var weatherData : TodayWeatherModel?
    private var viewModel  : TodayViewModelProtocol?
    private var coordinate : CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TodayViewModel()
        setupCallbacks()
        viewModel?.getLocationsFromFirebase()
    }
    override func viewWillAppear(_ animated: Bool) {
       viewModel?.getLocationsFromFirebase()
    }
    
    @IBAction func actionShareWeather(_ sender: UIButton) {
        if let _weatherData = weatherData {
            if let temp = _weatherData.main.temp,let city = _weatherData.name {
                let textToShare = "Current temperature in \(city) is \(temp)°C"
                let vc = UIActivityViewController(activityItems: [textToShare], applicationActivities: [])
                present(vc, animated: true)
            }
            showAlert(title: "Incomplete server response", message: "Please check with BO is everything okey with JSON.")
            
        }else {
            showAlert(title: "No weather data", message: "Unfortunately there are no weather data. Please try again...")
        }
    }
}
extension TodayViewController {
    private func setupCallbacks(){
        viewModel?.weatherData =  { [unowned self] (weather,error) in
            if let _error = error {
                self.showAlert(title: "Error".localizedLowercase, message: _error.localizedDescription)
                return
            }
            guard let coordinate = self.coordinate else { return }
            self.viewModel?.insertLocationToFirebase(latitude: coordinate.latitude, longitude: coordinate.longitude, temperature: Float(weather!.main.temp))
            let todayView =  self.view.customView(type: TodayView.self)
            self.weatherData = weather
            todayView.configure(weather: weather!)
            
        }
           viewModel?.firebaseData = { [unowned self] (location) in
           let todayView = self.view.customView(type: TodayView.self)
           todayView.configure(location: location)
        }
        
        viewModel?.locationManager.locationUpdateResult = { [unowned self](locations,error) in
            guard  error == nil else { return }
            if let _error = error {
                Logger.error(_error.localizedDescription)
                return
            }
            guard let location = locations?.last else { return }
            self.coordinate = location.coordinate
            self.viewModel?.getWeatherData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
        viewModel?.locationManager.startLocationMonitor()
    }
}




