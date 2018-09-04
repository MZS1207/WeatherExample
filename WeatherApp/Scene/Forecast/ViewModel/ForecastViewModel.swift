//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

protocol ForecastViewModelProtocol {
     func getForecastData(latitude : Double,longitude :Double)
     func data(section : Int ,forRowAt index: Int) -> ForecastModelCell
     func numberOfRows(inSection : Int)->Int
     func numberOfSections()->Int
     func lastRow()->Int
     func sectionTitle(inSection : Int)->String
     var  didReceiveForecastData: ((ForecastModel?, Error?) -> Void)? {get set}
     var  didReceiveForecastModelCell : (()->Void)? {get set}
}
class ForecastViewModel : ForecastViewModelProtocol {
   
    var didReceiveForecastData: ((ForecastModel?, Error?) -> Void)?
    var didReceiveForecastModelCell : (()->Void)?
    enum SectionsTitle : Int {
        case Today = 0
    }
    private var elements   = [[ForecastModelCell]]()
    private let imageCache = ImageCache()
    
    func numberOfRows(inSection : Int) -> Int {
        return elements[inSection].count
    }
    func numberOfSections() -> Int {
        return elements.count
    }
    func lastRow() -> Int {
        return elements.count
    }
    func data(section : Int, forRowAt index: Int) -> ForecastModelCell {
        return elements[section][index]
    }
    func sectionTitle(inSection : Int) -> String {
        let section = SectionsTitle(rawValue: inSection)
        switch section {
        case .Today?:
            return "Today".localizedLowercase
        default:
            return elements[inSection].first?.headerTitle ?? ""
        }
    }
    func getForecastData(latitude : Double,longitude :Double ){
        let worker = GetForecastWorker(latitude: latitude,longitude : longitude)
        worker.execute(success: { (forecastModel) in
            self.handleForecastModels(forecastModel: forecastModel)
            self.didReceiveForecastData?(forecastModel,nil)
        }){(error) in
            self.didReceiveForecastData?(nil,error)
        }
    }
    private func handleForecastModels(forecastModel : ForecastModel){
        
        let models = forecastModel.list.map { (list) -> ForecastModelCell in
            
            let dateTime    = Double(list.dt)
            let temperature = "\(Int(list.main.temp))°C"
            var weather     = "rain"
            var icon        = ""
            if let _weather = list.weather.first  {
                weather     = _weather.main.rawValue
                icon        = _weather.icon
            }
            imageCache.setImage(name: icon)
            let cellmodel = ForecastModelCell(icon : icon , imageCache: imageCache, dateTime: dateTime, weather: weather, temperature: temperature)
            return cellmodel
        }
        let elementsSorted =  models
        elements = groupArrays(seq: elementsSorted)
        didReceiveForecastModelCell?()
    }
}
