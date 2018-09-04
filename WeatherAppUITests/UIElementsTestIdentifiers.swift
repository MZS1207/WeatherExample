//
//  UIElementsTestIdentifiers.swift
//  WeatherAppUITests
//
//  Created by Milos Stevanovic on 8/29/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

enum UIElementTestIdentifiers : CustomStringConvertible {
    
    case testTabItemToday
    case testTabItemForecast
    case testImageWeatherLogo
    case testLabelCityName
    case testLabelTemperatureWeather
    case testImageHumadity
    case testHumidityLabel
    case testImagePrecipation
    case testPrecipationLabel
    case testImagePressure
    case testPressureLabel
    case testImageWind
    case testLabelWind
    case testImageDirectionWind
    case testLabelDirection
    case testShareButton
    case tesImagetForecastLogo
    case testLabelForecastTime
    case testLabelForecastTitle
    case testLabelForecastTemerature
    case testCellForecastCell
    case testTableViewForecast
    
    var description : String {
        switch self {
        case .testTableViewForecast:
            return "testTableViewForecast"
        case .testCellForecastCell:
            return "testCellForecastCell"
        case .testTabItemToday:
            return "testTabItemToday"
        case .testTabItemForecast:
            return "testTabItemForecast"
        case .testImageWeatherLogo:
            return "testImageWeatherLogo"
        case .testLabelCityName:
            return "testLabelCityName"
        case .testLabelTemperatureWeather:
            return "testLabelTemperatureWeather"
        case .testImageHumadity:
            return "testImageHumadity"
        case .testHumidityLabel:
            return "testHumidityLabel"
        case .testImagePrecipation:
            return "testImagePrecipation"
        case .testPrecipationLabel:
            return "testPrecipationLabel"
        case .testImagePressure:
            return "testImagePressure"
        case .testPressureLabel:
            return "testPressureLabel"
        case .testImageWind:
            return "testImageWind"
        case .testLabelWind:
            return "testLabelWind"
        case .testImageDirectionWind:
            return "testImageDirectionWind"
        case .testLabelDirection:
            return "testLabelDirection"
        case .testShareButton:
            return "testShareButton"
        case .tesImagetForecastLogo:
            return "tesImagetForecastLogo"
        case .testLabelForecastTime:
            return "testLabelForecastTime"
        case .testLabelForecastTitle:
            return "testLabelForecastTitle"
        case .testLabelForecastTemerature:
            return "testLabelForecastTemerature"
        }
    }
}
