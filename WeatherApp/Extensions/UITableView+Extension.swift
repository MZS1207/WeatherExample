//
//  UITableView+Extension.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/29/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: type.reuseIdentifier)
    }
    func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type, at indexPath: IndexPath) -> T {
        guard let cell =
            dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
                Logger.warning("Could not dequeue cell with identifier: \(T.reuseIdentifier).Creating new instance.")
                return T()
        }
        return cell
    }
}
