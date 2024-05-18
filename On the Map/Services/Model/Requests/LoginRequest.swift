//
//  LoginRequest.swift
//  On the Map
//
//  Created by Mateus Andreatta on 26/04/24.
//

import Foundation

struct LoginRequest: Codable {
    let udacity: UserData
    
    struct UserData: Codable {
        let username: String
        let password: String
    }
    
    init(email: String, password: String) {
        self.udacity = UserData(username: email, password: password)
    }
}
