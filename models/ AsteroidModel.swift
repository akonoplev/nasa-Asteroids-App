//
//  File.swift
//  nasaAsteroids
//
//  Created by Андрей Коноплев on 23.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation

class AsteroidModel {
    let name: String
    let minSize: Double
    let maxSize: Double
    let hazard: String
    let rangeToEarth: Double
    let orbited_body: String
    var averegeSize: Double {
        return (maxSize + minSize) / 2
    }
    
    init(name: String, minSize: Double, maxSize: Double, hazard: String, rangeToEarth: Double, orbited_body: String){
        self.name = name
        self.minSize = minSize
        self.maxSize = maxSize
        self.hazard = hazard
        self.rangeToEarth = rangeToEarth
        self.orbited_body = orbited_body
    }
}
