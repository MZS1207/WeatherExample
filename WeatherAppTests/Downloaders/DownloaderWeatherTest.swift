//
//  DownloaderWeatherTest.swift
//  WeatherAppTests
//
//  Created by Milos Stevanovic on 8/27/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import XCTest
@testable import WeatherApp

class DownloaderWeatherTest : XCTestCase {

    private let weatherDownloader = DownloaderWeather(latitude: 44.786568, longitude: 20.448921)
    
    func testFetchWeatherData(){
        let promise = expectation(description: "fetchWeather invoked")
        weatherDownloader.fetchWeather(success: { (model) in
            XCTAssertNotNil(model)
            promise.fulfill()
        }) { (error) in
            XCTFail("Request should succeed" + error.localizedDescription)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    func testFetchForecastData(){
        let promise = expectation(description: "fetchForecast invoked")
        weatherDownloader.fetchForecastWeather(success: { (model) in
            XCTAssertNotNil(model)
            promise.fulfill()
        }) { (error) in
            XCTFail("Request should succeed" + error.localizedDescription)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
}
