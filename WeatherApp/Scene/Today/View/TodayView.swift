//
//  TodayView.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/29/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import UIKit

class TodayView : UIView {
        @IBOutlet weak var labelTemperatureAndWeatherDescription: UILabel!
        @IBOutlet weak var labelCityName: UILabel!
        @IBOutlet weak var imageWeatherLogo: UIImageView!
        @IBOutlet weak var imageHumidity: UIImageView!
        @IBOutlet weak var labelHumidity: UILabel!
        @IBOutlet weak var imagePrecipitation: UIImageView!
        @IBOutlet weak var labelPrecipitation: UILabel!
        @IBOutlet weak var imagePressureOther: UIImageView!
        @IBOutlet weak var labelPresure: UILabel!
        @IBOutlet weak var labelWind: UILabel!
        @IBOutlet weak var imageWind: UIImageView!
        @IBOutlet weak var imageDirectionOfWind: UIImageView!
        @IBOutlet weak var labelDirection: UILabel!
        
        func configure(location : LocationModel){
            print("\(location)")
        }
        func configure(weather : TodayWeatherModel){
            labelCityName.text = weather.name ?? "no name"
            if let _temp = weather.main.temp, let _forecast = weather.weather.first?.main {
                labelTemperatureAndWeatherDescription.text = "\(Int(_temp))°C |\n \(_forecast)"
            }
            
            if let _humidity = weather.main.humidity {
                labelHumidity.text = "\(_humidity)" + "%"
            }
            if let _pressure = weather.main.pressure {
                labelPresure.text = "\(_pressure)" + "hPa"
            }
            
            if let _wind = weather.wind.speed {
                labelWind.text = String(_wind) + "km/h"
            }
            
            if let _direction = weather.wind.deg {
                labelDirection.text = _direction.direction.description
            }
            if let _logo = weather.weather.first?.icon {
                imageWeatherLogo.image = UIImage(named: _logo)
            }
        }
}

extension Double {
    var direction: Direction {
        return Direction(self)
    }
}

enum Direction: String {
    case n, nne, ne, ene, e, ese, se, sse, s, ssw, sw, wsw, w, wnw, nw, nnw
}

extension Direction: CustomStringConvertible  {
    static let all: [Direction] = [.n, .nne, .ne, .ene, .e, .ese, .se, .sse, .s, .ssw, .sw, .wsw, .w, .wnw, .nw, .nnw]
    init(_ direction: Double) {
        let index = Int((direction + 11.25).truncatingRemainder(dividingBy: 360) / 22.5)
        self = Direction.all[index]
    }
    var description: String {
        return rawValue.uppercased()
    }
}
