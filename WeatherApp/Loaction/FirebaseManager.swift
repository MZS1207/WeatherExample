//
//  FirebaseManager.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/28/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation
import Firebase

class FirebaseLocationManager {
    
    var location                  :  LocationModel!
    var models                    =  [LocationModel]()
    private var dataBaseReference :  DatabaseReference!
    private let relativePath      = "Users" //TODO: maybe better call this one Locations in Database
    private var queue             : DispatchQueue!
    
    init(location : LocationModel){
        self.location     = location
        dataBaseReference = Database.database().reference()
    }
    init(){
        dataBaseReference = Database.database().reference()
        queue = DispatchQueue(label:  "com.FirebaseLocationManagerQueue", qos: DispatchQoS.default)
    }
    func sendLocation(){
        guard  let locationJson  = location.json() else {
            Logger.warning("Can't make json from model.Check that your model confirm to Serializable protocol!")
            return
        }
        queue.async { [weak self] in
            self?.dataBaseReference.child((self?.relativePath)!).childByAutoId().setValue(locationJson)
        }
    }
    //TODO  : get all locations at one by guery or without 
    func getFirebaseLocationData( completion:@escaping((LocationModel?)->Void)){
        queue.async { [weak self] in
            self?.dataBaseReference.child((self?.relativePath)!).queryOrderedByKey().observe(.childAdded) { [weak self](dataSnapshot, _) in
                if let json =  dataSnapshot.value as? [String : Any] {
                    guard let jsonData = try? JSONSerialization.data(withJSONObject:json) ,
                        let model = try? LocationModel().decode(data: jsonData) else {
                            Logger.error("Can't make model from data!")
                            return
                    }
                    self?.models.append(model)
                    completion(model)
                }
            }
        }
    }
    deinit {
        dataBaseReference.removeAllObservers()
    }
}
struct LocationModel : Serializable {
    var temperature  : Float!
    var user         : User!
    var location     : Coordinate!
    
    init(){}
    
    init(user : User,location : Coordinate,temperature : Float){
        self.user        = user
        self.location    = location
        self.temperature = temperature
    }
    struct Coordinate: Serializable {
        var latitude     : Double
        var longitude    : Double
    }
    struct User : Serializable {
        
        var firstName    : String!
        var lastName     : String!
        
        init(firstName : String,lastName : String){
            self.firstName  = firstName
            self.lastName   = lastName
        }
    }
}
