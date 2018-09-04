//
//  Serializable.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/28/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

protocol Serializable : Codable {
    func encode()->Data?
    func decode(data : Data)throws -> Self
    func json()->[String : Any]?
}
enum SerializableError : LocalizedError {
    case invalidJson
    public var errorDescription: String? {
        switch  self{
        case .invalidJson: return "JSON parsing failed!"
        }
    }
}
extension Serializable {
    func encode()->Data?{
        do {
            let encoder = JSONEncoder()
            return try? encoder.encode(self)
        }
    }
    func decode(data : Data)throws -> Self{
        do {
            let decoder = JSONDecoder()
            let decodeData = try decoder.decode(type(of: self), from: data)
            return decodeData
        }catch {
            throw SerializableError.invalidJson
        }
    }
    func json()->[String : Any]? {
        if let data = encode() {
            guard let  json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)as? [String : Any] else { return nil}
           return json
        }
        return nil
    }
}
