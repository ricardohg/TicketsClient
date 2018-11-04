//
//  HttpClientTests.swift
//  TicketsAPPTests
//
//  Created by ricardo hernandez  on 8/13/18.
//  Copyright © 2018 Ricardo. All rights reserved.
//

import XCTest
@testable import TicketsAPP

class HttpClientTests: XCTestCase {
    
    var httpClient: HTTPClient!
    let session = MockUrlSession()
    
    
    override func setUp() {
        super.setUp()
        httpClient = HTTPClient(session: session)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_get_request_with_url() {
        
        guard let url = URL(string: "http://mock.com") else {
            assertionFailure("url is missing")
            return
            
        }
        
        httpClient.get(url: url, parameters: nil) { (data, response, error) in
            //
        }
        
        XCTAssert(session.lastURL == url)
        XCTAssert(session.lastHTTPMethod == "GET")
    }
    
    func test_get_with_parameters() {
        
        guard let url = URL(string: "http://mock.com") else {
            assertionFailure("url is missing")
            return
            
        }
        
        let params = ["data": "test"]
        
        httpClient.get(url: url, parameters: params) { (data, response, error) in
            //
        }
        
        if let lastParams = session.lastURL?.queryParameters {
            XCTAssert(lastParams == params)
            XCTAssert(session.lastHTTPMethod == "GET")
        }
        else {
            XCTAssert(false)
        }
        
    }
    
    func test_get_resume_called() {
        
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url, parameters: nil) { (data, response, error) in
            // Return data
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_get_should_return_data() {
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        let expectedData = "{}".data(using: .utf8)
        
        session.nextData = expectedData
        
        var actualData: Data?
        httpClient.get(url: url, parameters: nil) { (data, response, error) in
            actualData = data
        }
        
        XCTAssertNotNil(actualData)
    }
    
    func test_post_request_with_body() {
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        let testJsonDictionary = ["test": "test"]
        let jsonData = try! JSONSerialization.data(withJSONObject: testJsonDictionary, options: [])
        
        var statusCode: Int?
        
        httpClient.post(url: url, parameters: testJsonDictionary) { (data, response, error) in
            
            let httpResponse = response as? HTTPURLResponse
            statusCode = httpResponse?.statusCode

        }
        
        XCTAssert(session.bodyData == jsonData)
        XCTAssert(session.lastHTTPMethod == "POST")
        XCTAssertNotNil(statusCode)
        XCTAssert(statusCode ?? 0 == 200)
        
    }
    
    func test_forbidden_post_request_with_body() {
        
        guard let url = URL(string: "https://mockurl-fail") else {
            fatalError("URL can't be empty")
        }
        
        let testJsonDictionary = ["test": "test"]
        let jsonData = try! JSONSerialization.data(withJSONObject: testJsonDictionary, options: [])
        
        var statusCode: Int?
        
        httpClient.post(url: url, parameters: testJsonDictionary) { (data, response, error) in
            
            let httpResponse = response as? HTTPURLResponse
            statusCode = httpResponse?.statusCode
            
        }
        
        XCTAssert(session.bodyData == jsonData)
        XCTAssert(session.lastHTTPMethod == "POST")
        XCTAssertNotNil(statusCode)
        XCTAssert(statusCode ?? 0 == 403)
        
    }
    
}
