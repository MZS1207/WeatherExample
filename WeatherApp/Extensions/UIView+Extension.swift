//
//  UIView+Extension.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import UIKit

extension UIView {
    func makeRound() {
        self.layer.cornerRadius  = self.frame.size.height/2
        self.layer.masksToBounds = true
    }
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
extension UIView {
    func customView<T : UIView>( type : T.Type)->T{
        guard let _customView = self as? T else {
            Logger.warning("Could not return customView Type.Creating new instance.")
            return T()
        }
        return _customView
    }
}
