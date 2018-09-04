//
//  Request.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Alamofire

protocol Request {
    var path: String                { get }
    var method: HTTPMethod          { get }
    var parameters: Parameters?     { get }
    var headers: HTTPHeaders?       { get }
    var encoding: ParameterEncoding { get }
}
