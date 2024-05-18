//
//  PostStudentLocationRequest.swift
//  On the Map
//
//  Created by Mateus Andreatta on 13/05/24.
//

import Foundation

struct PostStudentLocationRequest: Codable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
}
