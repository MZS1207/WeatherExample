//
//  ForecastModelCell.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/31/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

struct ForecastModelCell {
    var icon             : String!
    var imageCache       : ImageCache!
    var time             : String!
    var weather          : String!
    var temperature      : String!
    var dayTitle         = ""
    var date             : Date!
    let uid              : Int = 0
    let dateTitle        : String = ""
    var headerTitle      = ""
    
    init(icon : String = "",imageCache : ImageCache ,dateTime : Double, weather : String = "", temperature : String = ""){
        self.icon        = icon
        self.imageCache  = imageCache
        let sepratedDatetime = timeStringFromUnixTime(unixTime: dateTime).components(separatedBy: " ")
        self.dayTitle    = sepratedDatetime[0]
        self.date        = toDate(date: sepratedDatetime[0])
        self.headerTitle = date.dayOfWeek()!
        self.time        = sepratedDatetime[1] + " " + sepratedDatetime[2]
        self.weather     = weather
        self.temperature = temperature
    }
    private mutating func timeStringFromUnixTime(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        return dateFormatter.string(from: date)
    }
    private lazy var dateFormatter : DateFormatter = {
        return DateFormatter()
    }()
    private mutating func toDate(date : String)->Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: date)
    }
}
extension ForecastModelCell : Hashable {
    var hashValue: Int {
        return uid.hashValue
    }
    static func == (lhs: ForecastModelCell, rhs: ForecastModelCell) -> Bool {
        return lhs.date == rhs.date
    }
}
