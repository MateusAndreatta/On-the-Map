//
//  StudentLocation.swift
//  On the Map
//
//  Created by Mateus Andreatta on 11/05/24.
//

import Foundation

struct StudentLocation: Codable {
    let firstName: String
    let lastName: String
    let longitude: Double
    let latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    let objectId: String
    let createdAt: String
    let updatedAt: String
}
