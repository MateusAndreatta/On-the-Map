//
//  LoginViewModel.swift
//  On the Map
//
//  Created by Mateus Andreatta on 26/04/24.
//

import Foundation

class LoginViewModel {

    init(){
        
    }
    
    public func login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        UdacityAPI.login(username: email, password: password) { success, error in
            if let error {
                completion(success, error.error)
                return
            }
            completion(success, nil)
        }
    }
}
