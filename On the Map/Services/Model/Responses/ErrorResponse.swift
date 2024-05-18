//
//  ErrorResponse.swift
//  On the Map
//
//  Created by Mateus Andreatta on 17/05/24.
//

import Foundation

struct ErrorResponse: Codable {
    let status: Int
    let error: String
}
