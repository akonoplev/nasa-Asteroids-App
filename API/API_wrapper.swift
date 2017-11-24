//
//  API_wrapper.swift
//  nasaAsteroids
//
//  Created by Андрей Коноплев on 23.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//
import Foundation

class API_wrapper {
    //MARK: - get Asteroids in json format
    static func getAsteroidsList(date: String ,success: @escaping (_ json: Any)-> Void, failure: @escaping (_ errorDescription: String)-> Void) -> URLSessionDataTask {
        let url = const.base_url.base_url
        let params : [String: Any] = [
            "start_date": date,
            "end_date": date,
            "api_key": const.api_params.api_key
        ]
        
        let request = API_conf.getRequst(url: url, params: params)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            API_conf.acceptDataFromServer(data: data, RequestError: error, success: success, failure: failure)
        }
        dataTask.resume()
        return dataTask
    }
}
