//
//  LocationOffViewController.swift
//  Sandd
//
//  Created by Milos Stevanovic on 8/21/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import UIKit
import CoreLocation

class LocationOffViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func openLocation(_ sender : Any) {
        if let url = NSURL(string: UIApplicationOpenSettingsURLString) as URL? {
            UIApplication.shared.open(url,completionHandler: nil)
        }
    }
}

