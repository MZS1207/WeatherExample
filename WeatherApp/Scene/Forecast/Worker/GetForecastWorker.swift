//
//  GetForecastWorker.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

private protocol GetForecastWorkerProtocol {
    func execute(success: RestClient.SuccessCompletion<ForecastModel>, failure: RestClient.FailureCompletion)
}
struct GetForecastWorker :  GetForecastWorkerProtocol{
    var latitude           : Double!
    var longitude          : Double!
    
    private let downloader : DownloaderWeather!
    
    init(latitude : Double,longitude : Double){
        self.latitude  = latitude
        self.longitude = longitude
        downloader = DownloaderWeather(latitude: latitude, longitude: longitude)
    }
    func execute(success: ((ForecastModel) -> Void)?, failure: RestClient.FailureCompletion) {
        downloader.fetchForecastWeather(success: { (forecastData) in
                success?(forecastData)
        }, failure: failure)
    }
}
