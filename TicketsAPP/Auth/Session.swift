//
//  Session.swift
//  TicketsAPP
//
//  Created by ricardo hernandez  on 8/15/18.
//  Copyright © 2018 Ricardo. All rights reserved.
//

import Foundation

private let authEndpoint = "https://escarlata.now.sh/auth"

final class Session {
    
    typealias LoginCompletion = (Bool, Error?) -> ()
    static let shared = Session()
    
    private (set) var isActive = false
    private (set) var token: String? = nil
    
    func startSession(token: String) {
        self.isActive = true
        self.token = token
    }
    
}

struct AuthResponse: Codable {
    let success: Bool
    let token: String
}

// MARK: -- API Handler

extension Session {
    
    func login(email: String, password: String, completion: @escaping LoginCompletion) {
        
        guard let url = URL(string: authEndpoint) else { return }
        
        let client = HTTPClient()
        let parameters = [
            "email": email,
            "password": password
        ]
        client.post(url: url, parameters: parameters) { (data, error) in
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let authResponse = try decoder.decode(AuthResponse.self, from: data)
                Session.shared.startSession(token: authResponse.token)
                completion(true, nil)
                
            }
            catch {
                completion(false, error)
                print(error)
            }
            
        }
    
    }
    
}


