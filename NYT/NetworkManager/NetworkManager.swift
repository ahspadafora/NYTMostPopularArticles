//
//  ApiManager.swift
//  NYT
//
//  Created by Amber Spadafora on 7/5/18.
//  Copyright © 2018 Amber Spadafora. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    typealias dataCallback = (Data)->()
    

    
    func startLoad(endpoint: String, apiKey: String?, apiKeyHeader: String?, callback: @escaping dataCallback){
        
        guard let endpointUrl = URL(string: endpoint) else { return }
        var request = URLRequest(url: endpointUrl)
        if let apiKey = apiKey, let apiKeyHeader = apiKeyHeader {
            request.setValue(apiKey, forHTTPHeaderField: apiKeyHeader)
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
            }
            guard let validData = data else {
                print("Could not unwrap data")
                return
            }
            callback(validData)
        })
        .resume()
    }
    
    func getData(from endpoint: URL, callback: @escaping dataCallback) {
        let session = URLSession.shared
        session.dataTask(with: endpoint) { (data, response, error) in
            if error != nil {
                print(error!)
            }
            guard let validData = data else {
                print("No data :(")
                return
            }
            callback(validData)
        }
        .resume()
    }
}
