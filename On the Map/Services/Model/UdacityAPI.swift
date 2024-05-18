//
//  UdacityAPI.swift
//  On the Map
//
//  Created by Mateus Andreatta on 26/04/24.
//

import Foundation

class UdacityAPI {
    
    static let baseEndpoint = "https://onthemap-api.udacity.com/v1"
    static private(set) var userData: UserDataResponse? = nil
    
    enum Endpoints {
        case login
        case logout
        case postLocation
        case getLocation
        case getUserData(String)
        
        var path: String {
           switch self {
           case .login, .logout:
               return "/session"
           case .postLocation:
               return "/StudentLocation"
           case .getLocation:
               return "/StudentLocation?order=-updatedAt&limit=100"
           case .getUserData(let userId):
               return "/users/\(userId)"
           }
       }
       
       var url: URL {
           return URL(string: "\(baseEndpoint)\(path)")!
       }
    }

    static func login(username: String, password: String, completion: @escaping (Bool, ErrorResponse?) -> Void) {
        let body = LoginRequest(email: username, password: password)
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try! JSONEncoder().encode(body)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { dirtyData, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(false, nil)
                }
                return
            }
          guard let dirtyData = dirtyData else {
              DispatchQueue.main.async {
                  completion(false, nil)
              }
              return
          }
            let range = 5..<dirtyData.count
            let newData = dirtyData.subdata(in: range)
            let decoder = JSONDecoder()
              let responseObject = try? decoder.decode(RequestTokenResponse.self, from: newData)
              let responseError = try? decoder.decode(ErrorResponse.self, from: newData)

              if let responseObject = responseObject {
                  getUserData(userId: responseObject.account.key)
                  DispatchQueue.main.async {
                      completion(true, nil)
                  }
              }
              if let responseError {
                  DispatchQueue.main.async {
                      completion(false, responseError)
                  }
              }
        }
        task.resume()
        
    }
    
    static func logout() {
        var request = URLRequest(url: Endpoints.logout.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request)
        task.resume()
    }
    
    static func getStudentLocations(completion: @escaping (StudentLocationResponse?, Error?) -> Void) {
        let request = URLRequest(url: Endpoints.getLocation.url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil, error)
            }
            if let data {
                let decoder = JSONDecoder()
                do {
                    let responseObject = try decoder.decode(StudentLocationResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    static func postStudentLocation(data: PostStudentLocationRequest, completion: @escaping (Bool?, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.postLocation.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(data)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            DispatchQueue.main.async {
                completion(true, nil)
            }
        }
        task.resume()
    }
    
    static func getUserData(userId: String) {
        let request = URLRequest(url: Endpoints.getUserData(userId).url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                return
            }
            guard let data else { return }
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            let decoder = JSONDecoder()
            userData = try? decoder.decode(UserDataResponse.self, from: newData)
        }
        task.resume()
    }
}
