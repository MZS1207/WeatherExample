//
//  NSObject+Extension.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

extension NSObject {
    
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
