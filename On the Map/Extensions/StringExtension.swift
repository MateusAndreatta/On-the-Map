//
//  StringExtension.swift
//  On the Map
//
//  Created by Mateus Andreatta on 14/05/24.
//

import Foundation

extension String {
    static let firstNames = [
        "Hardy", "Schuyler", "Victoria", "Abdul", "Jayda", "Mrs. Archibald", "Scarlett", "Michelle", "Triston", "Janie",
        "Miss Destini", "Emmanuelle", "Lisa", "Carlee", "Abel", "Ephraim", "Berneice", "Shemar", "Miss Lou", "Mohammad",
        "Murray", "Hazle", "Houston", "Virgil", "Minerva"
    ]
    
    static let lastNames = [
        "Moore", "Jerde", "Schaden", "Weber", "Huel", "Blick", "Kirlin", "Mertz", "Feil Sr.", "Wyman",
        "Schultz", "Oberbrunner", "Yost", "Runolfsdottir", "Schneider", "Zboncak", "Schaefer", "Smith", "O'Kon",
        "Kassulke", "Lockman", "Shanahan", "Blanda", "Lindgren II", "Crooks V"
    ]
    
    static func randomName() -> String {
        return firstNames.randomElement() ?? ""
    }
    
    static func randomLastname() -> String {
        return lastNames.randomElement() ?? ""
    }
}
