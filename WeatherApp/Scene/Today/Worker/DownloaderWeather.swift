//
//  DownloaderWeather.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

struct DownloaderWeather {

    var latitude  : Double!
    var longitude : Double!
    
    init(latitude : Double,longitude : Double){
        self.latitude  = latitude
        self.longitude = longitude
    }
    func fetchWeather(success: RestClient.SuccessCompletion<TodayWeatherModel>, failure: RestClient.FailureCompletion) {
        RestClient.shared.request(WeatherRequest.weather(latitude: latitude, longitude: longitude), success: { (data) in
            do {
                let weatherData  = try Parser.shared.decodeData(type : TodayWeatherModel.self, data: data)
                success?(weatherData)
            }catch {
                 let responseError = error as? RemoteResourceError ??
                    RemoteResourceError.noData
                failure?(responseError)
            }
        }, failure: failure)
    }
    func fetchForecastWeather(success: RestClient.SuccessCompletion<ForecastModel>, failure: RestClient.FailureCompletion) {
        RestClient.shared.request(ForeCastRequest.forecast(latitude: latitude, longitude: longitude), success: { (data) in
            do {
                let forecastData  = try Parser.shared.decodeData(type : ForecastModel.self, data: data)
                
                success?(forecastData)
            }catch {
                let responseError = error as? RemoteResourceError ??
                    RemoteResourceError.noData
                failure?(responseError)
            }
        }, failure: failure)
    }
}
