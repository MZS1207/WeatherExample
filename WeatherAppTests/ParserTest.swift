//
//  ParserTest.swift
//  WeatherAppTests
//
//  Created by Milos Stevanovic on 8/27/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import XCTest
@testable import WeatherApp

class ParserTest : XCTestCase {
    
    let weatherDataMock  = WeatherDataMock().mockDataEntity()
    let forecastDataMock = ForecastDataMock().mockDataEntity()
    let firebaseDataMock = FirebaseDataMock().mockDataEntity()
    
    func testParser() {
        do {
            XCTAssertNotNil(weatherDataMock)
            guard let _weatherDataMock = weatherDataMock else { return }
            let entity = try Parser.shared.decodeData(type: TodayWeatherModel.self, data: _weatherDataMock)
            XCTAssertNotNil(entity)
        }catch {
            Logger.error(error.localizedDescription)
            XCTAssertNil(error)
        }
    }
    func testParsingForecastModel(){
        do {
            XCTAssertNotNil(forecastDataMock)
            guard let _forecastDataMock = forecastDataMock else { return }
            let entity = try Parser.shared.decodeData(type: ForecastModel.self, data: _forecastDataMock)
            XCTAssertNotNil(entity)
        }catch {
            Logger.error(error.localizedDescription)
            XCTAssertNil(error)
        }
    }
    func testParsingFirebaseModel(){
        do {
            XCTAssertNotNil(firebaseDataMock)
            guard let _firebaseDataMock = firebaseDataMock else { return }
            let entity = try Parser.shared.decodeData(type: LocationModel.self, data: _firebaseDataMock)
            XCTAssertNotNil(entity)
        }catch {
            Logger.error(error.localizedDescription)
            XCTAssertNil(error)
        }
    }
}
