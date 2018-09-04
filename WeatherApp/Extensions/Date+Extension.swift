//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 9/3/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//

import Foundation
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
