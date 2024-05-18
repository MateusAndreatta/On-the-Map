//
//  ListViewModel.swift
//  On the Map
//
//  Created by Mateus Andreatta on 18/05/24.
//

import Foundation

class ListViewModel {
    private(set) var locationData: [StudentLocation] = []
    
    func updateData(with locations: [StudentLocation]) {
        self.locationData = locations
    }
}
