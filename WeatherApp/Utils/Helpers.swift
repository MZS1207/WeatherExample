//
//  Helpers.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation

func mainThread(_ block: @escaping()->Void){
    DispatchQueue.main.async {
        block()
    }
}
func delay(seconds : Double , task:@escaping()->Void){
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: task)
}

func groupArrays<S: Sequence>(seq: S) -> [[S.Iterator.Element]] where S.Iterator.Element: Equatable {
    var result: [[S.Iterator.Element]] = []
    var current: [S.Iterator.Element]  = []
    for element in seq {
        if current.isEmpty || element == current[0] {
            current.append(element)
        } else {
            result.append(current)
            current = [element]
        }
    }
    result.append(current)
    return result
}
