//
//  WeatherDataMock.swift
//  WeatherAppTests
//
//  Created by Milos Stevanovic on 8/27/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation
import XCTest
@testable import WeatherApp

class WeatherDataMock : XCTestCase {
    func mockDataEntity()->Data?{
        return mockGetWeatherData()
    }
    func mockGetWeatherData()->Data?{
        do {
            let data = try loadDataFromFile("weather")
            return data
        }catch {
            Logger.error(error.localizedDescription)
        }
        return nil
    }
}
private extension WeatherDataMock {
    func loadDataFromFile(_ file: String) throws -> Data{
        guard let path = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") else { throw RemoteResourceError.generic }
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return data
    }
}
