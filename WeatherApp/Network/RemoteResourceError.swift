//
//  RemoteResourceError.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

enum RemoteResourceError: LocalizedError {
    case noInternetConnection
    case timeout
    case server(statusCode: Int)
    case request(statusCode: Int)
    case invalidCredentials
    case invalidResponse
    case invalidJson
    case noData
    case generic
    case notValidUrl
    
    public var errorDescription: String? {
        switch self {
        case .noInternetConnection: return "No internet connection!"
        case .timeout: return "Request timeout!"
        case let .server(statusCode): return "Server error with status code: \(statusCode)!"
        case let .request(statusCode): return "Request error with status code: \(statusCode)!"
        case .invalidCredentials: return "Invalid credentials!"
        case .invalidResponse: return "Invalid response!"
        case .generic: return "Generic error!"
        case .invalidJson: return "JSON parsing failed!"
        case .noData: return "Data is empty!"
        case .notValidUrl: return "Not valid URL!"
        }
    }
}
