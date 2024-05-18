//
//  HomeViewModel.swift
//  On the Map
//
//  Created by Mateus Andreatta on 11/05/24.
//

import Foundation

class HomeViewModel {
    
    var locationData: [StudentLocation] = []
    
    func loadStudentLocations(completion: @escaping (Bool) -> Void) {
        UdacityAPI.getStudentLocations { [weak self] response, error in
            if let response {
                self?.locationData = response.results
                completion(true)
                return
            }
            completion(false)
        }
    }
}
