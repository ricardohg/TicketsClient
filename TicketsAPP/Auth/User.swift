//
//  User.swift
//  TicketsAPP
//
//  Created by ricardo hernandez  on 8/15/18.
//  Copyright © 2018 Ricardo. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: String
    let role: String
    let isActive: Bool
    let email: String
}
