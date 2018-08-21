//
//  Event.swift
//  TicketsAPP
//
//  Created by ricardo hernandez  on 8/13/18.
//  Copyright © 2018 Ricardo. All rights reserved.
//

import Foundation

private let eventEndpoint = "http://localhost:8080/events"

struct Event: Codable {
    
    let id: Int
    let name: String
    let description: String
    let price: Double
    let imageurl: String
    //let createdat: Date
    
}

struct EventResponse: Codable {
    let events: [Event]
}

// API Call Handler

extension Event {
    
    typealias EventClosure = ([Event]?) -> ()
    static func getEvents(limit: Int, offset: Int, completion: @escaping EventClosure) {
        
        guard let url = URL(string: eventEndpoint) else { return }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let client = HTTPClient(session: session)
        
        client.get(url: url, parameters: ["limit":"\(limit)", "offset": "\(offset)"]) { (data, error) in
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let eventsJson = try decoder.decode(EventResponse.self, from: data)
                completion(eventsJson.events)
                
            }
            catch {
                completion(nil)
                print(error)
            }
            
        }
        
        
    }
}
