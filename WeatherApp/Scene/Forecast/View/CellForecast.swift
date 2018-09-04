//
//  CellForecast.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/27/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import UIKit

class CellForecast: UITableViewCell {
    
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var imageForecastWeatherLogo: UIImageView!
    @IBOutlet weak var labelForecastTime: UILabel!
    @IBOutlet weak var labelForecastTitle: UILabel!
    
    func configure(model : ForecastModelCell) {
        imageForecastWeatherLogo.image = model.imageCache.image(name: model.icon)
        labelForecastTime.text   = model.time
        labelForecastTitle.text  = model.weather
        lblTemperature.text      = model.temperature
        layer.shouldRasterize    = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    override func prepareForReuse() {
       imageForecastWeatherLogo.image = nil
       super.prepareForReuse()
    }
}
