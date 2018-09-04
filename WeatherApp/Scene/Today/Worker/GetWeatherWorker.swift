//
//  GetWeatherWorker.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

private protocol GetWeatherWorkerProtocol {
     func execute(success: RestClient.SuccessCompletion<TodayWeatherModel>, failure: RestClient.FailureCompletion)
}
struct GetWeatherWorker :  GetWeatherWorkerProtocol{
    var latitude           : Double!
    var longitude          : Double!
    
    private let downloader : DownloaderWeather!
    
    init(latitude : Double,longitude : Double){
        self.latitude  = latitude
        self.longitude = longitude
        downloader = DownloaderWeather(latitude: latitude, longitude: longitude)
    }
    func execute(success: RestClient.SuccessCompletion<TodayWeatherModel>, failure: RestClient.FailureCompletion) {
        downloader.fetchWeather(success: { (weatherData) in
               success?(weatherData)
        }, failure: failure)
    }
}
