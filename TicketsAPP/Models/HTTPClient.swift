//
//  HTTPClient.swift
//  TicketsAPP
//
//  Created by ricardo hernandez  on 8/13/18.
//  Copyright © 2018 Ricardo. All rights reserved.
//

import Foundation

final class HTTPClient {
    
    private enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    typealias CompleteClosure = ((Data?, Error?) -> ())
    typealias JSON = [String: Any]
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func get(url: URL, callback: @escaping CompleteClosure) {
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        let task = session.dataTask(with: request as NSURLRequest) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
    
    func post(url: URL, parameters: JSON?, callback: @escaping CompleteClosure) {
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        if let params = parameters, let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) {
            request.httpBody = jsonData
            
        } else {
            print("Error constructing http body")
        }
        
        let task = session.dataTask(with: request as NSURLRequest) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
        
    }
}
