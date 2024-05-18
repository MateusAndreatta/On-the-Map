//
//  RequestTokenResponse.swift
//  On the Map
//
//  Created by Mateus Andreatta on 11/05/24.
//

import Foundation

struct RequestTokenResponse: Codable {
    
    let account: Account
    let session: Session
    
    struct Account: Codable {
        let registered: Bool
        let key: String
    }
    
    struct Session: Codable {
        let id: String
        let expiration: String
    }
    
}
