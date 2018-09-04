//
//	TodayWeatherModel.swift
//
//	Create by Milos Stevanovic on 26/8/2018
//	Copyright © 2018. All rights reserved.
import Foundation

struct TodayWeatherModel : Codable {
    
    var base    : String!
    var clouds  : Clouds!
    var cod     : Int!
    var coord   : Coord!
    var dt      : Int!
    var id      : Int!
    var main    : Main!
    var name    : String!
    var sys     : Sys!
    var weather : [Weather]!
    var wind    : Wind!
    var visibility: Int!
    
    
    
    struct Cloud : Codable {
        
        var all  : Int!
    }
    struct Coord : Codable {
        
        var lat : Double!
        var lon : Double!
    }
    struct Clouds: Codable {
        var all: Int
    }
    
    struct Sys : Codable {
        var pod : String!
        var country : String!
        var message : Float!
        var sunrise : Int!
        var sunset  : Int!
    }
    struct Weather : Codable {
        var id: Int
        var main, description, icon: String
        
    }
    struct Wind : Codable {
        var speed, deg: Double?
    }
    struct Main : Codable {
        var temp: Double!
        var pressure, humidity, tempMin, tempMax: Int!
    }
}

