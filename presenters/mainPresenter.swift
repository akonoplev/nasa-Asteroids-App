//
//  mainPresenter.swift
//  nasaAsteroids
//
//  Created by Андрей Коноплев on 23.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation

class mainPresenter {
    weak var view: mainVC!
}

extension mainPresenter {
    
    func initialPresenter(view: mainVC) {
        self.view = view
    }
    
    func getAsteroids() {
        asteroidListManager.getAsteroidList(date: self.view.date, success: { (asteroidsArray) in
            DispatchQueue.main.async {
                self.view.asteroidArray.removeAll()
                self.view.asteroidArray.append(contentsOf: asteroidsArray)
                self.view.addAsteroids()
            }
        }) { (error) in
            print(error)
        }
    }
}

//MARK: - get and form date for request
extension mainPresenter {
    func formDate() {
        let date = self.view.datePicker.date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        self.view.date = dateFormater.string(from: date)
    }
}


