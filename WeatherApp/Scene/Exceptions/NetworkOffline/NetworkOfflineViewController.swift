//
//  NetworkOfflineViewController.swift
//  Sandd
//
//  Created by Milos Stevanovic on 8/21/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import UIKit

class NetworkOfflineViewController: UIViewController {
    @IBOutlet weak var imageLoading: UIImageView!
    @IBOutlet weak var labelOfflineTitle: UILabel!
    @IBOutlet weak var labelOfflineSubtitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLoading.makeRound()

    }
    override func viewWillAppear(_ animated: Bool) {
    NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(_:)), name: .UIApplicationDidBecomeActive, object: nil)
    }
    @objc func willEnterForeground(_ notification: NSNotification!) {
        dismiss(animated: true, completion: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func openSettings(_ sender : Any) {
        if let url = NSURL(string: UIApplicationOpenSettingsURLString) as URL? {
            UIApplication.shared.open(url,completionHandler: nil)
        }
    }
}
