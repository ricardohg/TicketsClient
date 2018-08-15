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
    
    func get(url: URL, parameters:[String: String]?, callback: @escaping CompleteClosure) {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("Error creating url")
            return
        }
        
        var components: [URLQueryItem] = []
        
        parameters?.forEach { parameter in
            components.append(URLQueryItem(name: parameter.key, value: parameter.value))
        }
        
        if let _ = parameters {
            urlComponents.queryItems = components
        }
        
        if let urlRequest = urlComponents.url {
            
            let request = NSMutableURLRequest(url: urlRequest)
            
            request.httpMethod = HTTPMethod.get.rawValue
            let task = session.dataTask(with: request as NSURLRequest) { (data, response, error) in
                callback(data, error)
            }
            task.resume()
        } else {
            print("Error creating url")
        }
        
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

// URL Extension to get query parameters

extension URL {
    
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return nil
        }
        
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        
        return parameters
    }
}
