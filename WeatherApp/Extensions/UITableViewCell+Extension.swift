//
//  UITableViewCell+Extension.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/29/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
