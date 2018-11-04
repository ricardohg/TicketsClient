//
//  MockUrlSession.swift
//  TicketsAPP
//
//  Created by ricardo hernandez  on 8/13/18.
//  Copyright © 2018 Ricardo. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse? , Error?) -> Void
    func task(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

//MARK: conform to protocol

extension URLSession: URLSessionProtocol {
    
    func task(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
         return self.dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

class MockUrlSession: URLSessionProtocol {
    
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    
    fileprivate (set) var lastURL: URL?
    fileprivate (set) var bodyData: Data?
    fileprivate (set) var lastHTTPMethod: String?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func forbiddenHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 403, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func task(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        bodyData = request.httpBody
        lastHTTPMethod = request.httpMethod
        
        var shouldSendForbiddenResponse = false
        
        if let url = lastURL, url.absoluteString != "https://mockurl" {
            shouldSendForbiddenResponse = true
        }
        
        let request = shouldSendForbiddenResponse ? forbiddenHttpURLResponse(request: request) : successHttpURLResponse(request: request)
        
        completionHandler(nextData, request, nextError)
        return nextDataTask
    }
    

}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
