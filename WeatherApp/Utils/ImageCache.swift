//
//  ImageCache.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/31/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import UIKit

class ImageCache {
    private var imageCache = [String : UIImage]()
    
    init(){}
    func image(name: String)->UIImage? {
        
        if let cachedImage = imageCache[name] {
            return cachedImage
        } else {
            guard let image = UIImage(named: name) else { return nil }
            imageCache[name] = image
            return image
        }
    }
    func setImage(name: String){
        guard let image = UIImage(named: name) else { return }
        imageCache[name] = image
    }
}
