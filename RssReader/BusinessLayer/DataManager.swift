//
//  DataManager.swift
//  RssReader
//
//  Created by vladislav on 07.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class DataManager {
    func getTopicData(url: String, topicData: @escaping (Data) -> Void) {
        let api = API()
        api.request(for: url, success: { (data) in
            topicData(data)
        }) { (error) in
            print(error)
        }
    }
    
}
