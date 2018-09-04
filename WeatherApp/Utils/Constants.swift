//
//  Constants.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

enum Constants {
    /// Environment constants
    enum Environment {
        #if CONFIGURATION_Debug
        static let isDebug = true
        #else
        static let isDebug = false
        #endif
        
        // WARNING: A lot of features (logging) on this variable
        // isProduction *MUST* only be true for App Store builds.
        //
        #if CONFIGURATION_AppStore
        static let isProduction = true
        #else
        static let isProduction = false
        #endif
        
        static let isTesting = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
        static let isDebugOrTest = isDebug || isTesting
    }
}
