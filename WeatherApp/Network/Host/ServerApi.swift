//
//  ServerApi.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

public protocol ServerApiProtocol : CustomStringConvertible {
    var description: String { get }
}

enum ServerApi : ServerApiProtocol {
    case openWeatherMapGetWeather(latitude : Double,longitude:Double)
    case forecastGetForecast(latitude : Double,longitude:Double)
    
    var description: String {
        switch self {
        case let .openWeatherMapGetWeather(latitude,longitude):
            return  "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&direction=code&appid=\(ApiKey.shared.key)"
            
        case let .forecastGetForecast(latitude,longitude):
            return  "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&units=metric&direction=code&appid=\(ApiKey.shared.key)"
        }
    }
}
