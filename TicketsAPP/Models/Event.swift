//
//  Event.swift
//  TicketsAPP
//
//  Created by ricardo hernandez  on 8/13/18.
//  Copyright © 2018 Ricardo. All rights reserved.
//

import Foundation

struct Event: Codable {
    
    let id: Int
    let name: String
    let description: String
    let price: Double
    let imageurl: String
    //let createdat: String
    
}

struct EventResponse: Codable {
    let events: [Event]
}

