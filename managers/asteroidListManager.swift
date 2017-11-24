//
//  asteroidListManager.swift
//  nasaAsteroids
//
//  Created by Андрей Коноплев on 23.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation
import SwiftyJSON

class asteroidListManager {
    static func getAsteroidList(date: String, success: @escaping (_ asteroids: [AsteroidModel])-> Void, failure: (_ error: String)-> Void) {
        _ = API_wrapper.getAsteroidsList(date: date, success: { (response) in
            var asteroidsArray = [AsteroidModel]()
            var sortedAndFilteredArray = [AsteroidModel]()
            let responseArray = JSON(response)
            
            let arrayOfAsteroids = responseArray["near_earth_objects" ][date].arrayValue
            for asteroid in arrayOfAsteroids {
                let name = asteroid["name"].stringValue
                let minSize = asteroid["estimated_diameter"]["meters"]["estimated_diameter_min"].doubleValue
                let maxSize = asteroid["estimated_diameter"]["meters"]["estimated_diameter_max"].doubleValue
                let hazard = asteroid["is_potentially_hazardous_asteroid"].stringValue
                let rangeToEarth = asteroid["close_approach_data"][0]["miss_distance"]["kilometers"].doubleValue
                let orbited_body = asteroid["close_approach_data"][0]["orbiting_body"].stringValue
                
                let newAsteroid = AsteroidModel(name: name, minSize: minSize, maxSize: maxSize, hazard: hazard, rangeToEarth: rangeToEarth, orbited_body: orbited_body)
                
                asteroidsArray.append(newAsteroid)
            }
            
            sortedAndFilteredArray = asteroidsArray.filter{i in i.orbited_body == "Earth"}.sorted(by: { $0.rangeToEarth > $1.rangeToEarth })
            
            success(sortedAndFilteredArray)
        }, failure: { (error) in
            print(error)
        })
    }
}

