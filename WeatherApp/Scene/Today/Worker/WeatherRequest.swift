//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Alamofire

enum WeatherRequest : Request {
    
    case weather(latitude : Double,longitude : Double)
    
    var path: String {
        switch self {
        case let .weather(latitude,longitude):
            return ServerApi.openWeatherMapGetWeather(latitude: latitude, longitude:longitude).description
      }
    }
}
extension WeatherRequest  {
    var method: HTTPMethod {
        return .get
    }
    var parameters: Parameters? {
        return nil
    }
    var headers: HTTPHeaders? {
        return nil
    }
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}

enum ForeCastRequest : Request {

    case forecast(latitude : Double,longitude : Double)
    
    var path: String {
        switch self {
        case  let .forecast(latitude,longitude):
            return ServerApi.forecastGetForecast(latitude: latitude, longitude: longitude).description
        }
    }
}
extension ForeCastRequest {
    var method: HTTPMethod {
        return .get
    }
    var parameters: Parameters? {
        return nil
    }
    var headers: HTTPHeaders? {
        return nil
    }
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
