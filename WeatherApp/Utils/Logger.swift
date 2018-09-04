//
//  Logger.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

/// Log levels
enum LogLevel: Int {
    case none=0, error, warn, info, debug, all
    
    func string() -> String {
        switch self {
        case .info:  return "INFO"
        case .warn:  return "WARN"
        case .debug: return "DEBUG"
        case .error: return "ERROR"
        default: return ""
        }
    }
}
class Logger {
    
    typealias Json = [String: Any]
    
    static let shared = Logger()
    
    /// Log level
    var logLevel: LogLevel = Constants.Environment.isProduction ? .info : .debug
    
    // MARK: - Class Methods
    /// Log debug message
    static func debug(_ message: String, params: Json?=nil, file: String = #file, function: String = #function, line: Int = #line) {
        if shared.logLevel.rawValue >= LogLevel.debug.rawValue {
            flush(.debug, message: message, params: params, file: file, function: function, line: line)
        }
    }
    
    /// Log info message
    static func info(_ message: String, params: Json?=nil, file: String = #file, function: String = #function, line: Int = #line) {
        if shared.logLevel.rawValue >= LogLevel.info.rawValue {
            flush(.info, message: message, params: params, file: file, function: function, line: line)
        }
    }
    
    /// Log warning message
    static func warning(_ message: String, params: Json?=nil, file: String = #file, function: String = #function, line: Int = #line) {
        if shared.logLevel.rawValue >= LogLevel.warn.rawValue {
            flush(.warn, message: message, params: params, file: file, function: function, line: line)
        }
    }
    
    /// Log error message
    static func error(_ message: String, params: Json?=nil, file: String = #file, function: String = #function, line: Int = #line) {
        if shared.logLevel.rawValue >= LogLevel.error.rawValue {
            flush(.error, message: message, params: params, file: file, function: function, line: line)
        }
    }
    
    // MARK: - Private Methods
    private static func flush(_ level: LogLevel, message: String, params: Json?=nil, file: String, function: String, line: Int) {
        let fileName = URL(fileURLWithPath: file).lastPathComponent.components(separatedBy: ".").first ?? ""
        let validParams = params == nil ? "" : ", params: \(params!)"
        
        // log remote only if not debug and app environment is not testing
        if shared.logLevel.rawValue >= level.rawValue {
            debugPrint("\(level.string()): \(fileName).\(function)[\(line)]: \(message)\(validParams)")
            debugPrint()
        }
    }
}
