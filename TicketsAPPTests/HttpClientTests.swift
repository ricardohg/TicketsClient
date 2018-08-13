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
        
        httpClient.get(url: url) { (data, error) in
            //
        }
        
        assert(session.lastURL == url)
    }
    
    func test_get_resume_called() {
        
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url) { (success, response) in
            // Return data
        }
        
        assert(dataTask.resumeWasCalled)
    }
    
    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)
        
        session.nextData = expectedData
        
        var actualData: Data?
        httpClient.get(url: URL(string: "http://mockurl")!) { (data, error) in
            actualData = data
        }
        
        XCTAssertNotNil(actualData)
    }
    
}
