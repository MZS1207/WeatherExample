//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/29/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import UIKit
import CoreLocation

class BaseViewController : UIViewController {
    func showAlert(title : String,message : String){
        mainThread {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localizedLowercase, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
    }
}
extension BaseViewController {
    
}


