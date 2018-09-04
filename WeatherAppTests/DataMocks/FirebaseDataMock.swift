//
//  FirebaseDataMock.swift
//  WeatherAppTests
//
//  Created by Milos Stevanovic on 8/29/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

import Foundation
import XCTest
@testable import WeatherApp

class FirebaseDataMock : XCTestCase {
    func mockDataEntity()->Data?{
        return mockFirebaseLocationData()
    }
    func mockFirebaseLocationData()->Data?{
        do {
            let data = try loadDataFromFile("firebaseLocation")
            return data
        }catch {
            Logger.error(error.localizedDescription)
        }
        return nil
    }
}
private extension FirebaseDataMock {
    func loadDataFromFile(_ file: String) throws -> Data{
        guard let path = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") else { throw RemoteResourceError.generic }
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return data
    }
}
