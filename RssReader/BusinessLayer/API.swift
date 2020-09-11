//
//  API.swift
//  RssReader
//
//  Created by vladislav on 07.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

enum TopicThemes: String {
    case mainURL = "feeds.dzone.com"
    case all = "/home"
    case agile = "/agile"
    case AI = "/ai"
    case bigData = "/big-data"
    case cloud = "/cloud"
    case dataBase = "/database"
    case devOps = "/devops"
    case integration = "/integration"
    case IOT = "/iot"
    case java = "/java"
    case microServices = "/microservices"
    case openSource = "/open-source"
    case perfomance = "/perfomance"
    case security = "/security"
    case webDev = "/webdev"
    
}

class API {
    func request(for url: String, success: @escaping (Data) -> Void, failure: @escaping (URLResponse?) -> Void) {
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, error, _)  in
            if let data = data {
                success(data)
            } else {
                failure(error)
            }
        }
        task.resume()
    }

}
