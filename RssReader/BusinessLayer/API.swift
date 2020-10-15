//
//  API.swift
//  RssReader
//
//  Created by vladislav on 07.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import SystemConfiguration

class API {
    
    static let shared = API()
    
    private init() {}
    
    func request(for url: String, success: @escaping (Data) -> Void, failure: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = APIConstants.mainURL.rawValue
        urlComponents.path = "/\(url)"
        
        guard let resultURL = urlComponents.url else { return }
        
        let request = URLRequest(url: resultURL)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, _, error)  in
            if let data = data {
                success(data)
            } else {
                failure(error)
            }
        }
        task.resume()
    }
    func requestForGetData(for url: String, success: @escaping (Data) -> Void, failure: @escaping (Error?) -> Void) {
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, _, error)  in
            if let data = data {
                success(data)
            } else {
                failure(error)
            }
        }
        task.resume()
    }
    func getInternetActivity() -> Bool {
        var flags : SCNetworkReachabilityFlags = []
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)}
        } ) else {
            return false
        }

        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {return false}
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
}
