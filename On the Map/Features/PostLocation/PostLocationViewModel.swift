//
//  PostLocationViewModel.swift
//  On the Map
//
//  Created by Mateus Andreatta on 11/05/24.
//

import Foundation

class PostLocationViewModel {
    
    func submitStudentLocationData(link: String, search: String, latitude: Double, longitude: Double, completion: @escaping (Bool?, Error?) -> Void) {
        let request = PostStudentLocationRequest(uniqueKey: UUID().uuidString,
                                                 firstName: UdacityAPI.userData?.first_name ?? "",
                                                 lastName: UdacityAPI.userData?.last_name ?? "",
                                                 mapString: search,
                                                 mediaURL: link,
                                                 latitude: latitude,
                                                 longitude: longitude)
        UdacityAPI.postStudentLocation(data: request, completion: completion)
    }
}
