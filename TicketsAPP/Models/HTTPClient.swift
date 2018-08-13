//
//  HTTPClient.swift
//  TicketsAPP
//
//  Created by ricardo hernandez  on 8/13/18.
//  Copyright © 2018 Ricardo. All rights reserved.
//

import Foundation

final class HTTPClient {
    
    typealias CompleteClosure = ((Data?, Error?) -> ())
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func get(url: URL, callback: @escaping CompleteClosure) {
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as NSURLRequest) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
}
