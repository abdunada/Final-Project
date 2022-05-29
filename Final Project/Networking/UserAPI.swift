//
//  ProfileAPI.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 27/04/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserAPI: API {
    
    // MARK: - Get UserData
    static func getUserData(id: String, completionHandler: @escaping (User) -> ()) {
        
        // MARK: - Get Response API
        let url = "\(baseURL)/user/\(id)"
        
        // MARK: - loaderIndicatorView
        AF.request(url, headers: headers).responseJSON { response in
            
            let jsonData = JSON(response.value)
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: jsonData.rawData())
                
                completionHandler(user)
            } catch let error {
                
            }
        }
    }
    
    // MARK: - Register New User
    static func registerNewUser(firstName: String, lastName: String, email: String , completionHandler: @escaping (User?, String?) -> ()) {
        
        // MARK: - Get Response API
        let url = "\(baseURL)/user/create"
        let params = [
            "firstName" : firstName,
            "lastName" : lastName,
            "email" : email
        ]
        // MARK: - loaderIndicatorView
        AF.request(url, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            
            switch response.result {
                // MARK: - Success Response
            case .success:
                let jsonData = JSON(response.value)
                print(jsonData)
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    
                    completionHandler(user, nil)
                    
                } catch let error {
                    print(error)
                }
                // MARK: - Failure Response
            case .failure(let error):
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                
                // MARK: - Error Messages
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let emailError = data["email"].stringValue
                let errorMessage = firstNameError + " " + lastNameError + " " + emailError
                
                completionHandler(nil, errorMessage)
            }
        }
    }
    
    // MARK: - loginUser User
    static func loginUser(firstName: String, lastName: String, completionHandler: @escaping (User?, String?) -> ()) {
        
        // MARK: - Get Response API
        let url = "\(baseURL)/user/"
        let params = [
            "created" : "1"
        ]
        // MARK: - loaderIndicatorView
        AF.request(url, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: headers).validate().responseJSON { response in
            
            switch response.result {
                // MARK: - Success Response
            case .success:
                let jsonData = JSON(response.value)
                let data = jsonData["data"]
                print(jsonData)
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode([User].self, from: data.rawData())
                    
                    var foundUser: User?
                    for user in users {
                        if user.firstName == firstName && user.lastName == lastName {
                            foundUser = user
                            break
                        }
                    }
                    
                    if let user = foundUser {
                        completionHandler(user, nil)
                    } else {
                        completionHandler(nil, "The firstName or lastName don't match any user.")
                    }
                    
                    
                } catch let error {
                    print(error)
                }
                // MARK: - Failure Response
            case .failure(let error):
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                
                // MARK: - Error Messages
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let emailError = data["email"].stringValue
                let errorMessage = firstNameError + " " + lastNameError + " " + emailError
                
                completionHandler(nil, errorMessage)
            }
        }
    }
    
    // MARK: - Update User info
    static func updateUserInfo(firstName: String, userId: String, phone: String, imageUrl: String, completionHandler: @escaping (User?, String?) -> ()) {
        
        // MARK: - Get Response API
        let url = "\(baseURL)/user/\(userId)"
        let params = [
            "firstName" : firstName,
            "phone" : phone,
            "picture" : imageUrl
            
        ]

        AF.request(url, method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            
            switch response.result {
                // MARK: - Success Response
            case .success:
                let jsonData = JSON(response.value)
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    
                    completionHandler(user, nil)

                } catch let error {
                    print(error)
                }
                // MARK: - Failure Response
            case .failure(let error):
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                
                // MARK: - Error Messages
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let emailError = data["email"].stringValue
                let errorMessage = firstNameError + " " + lastNameError + " " + emailError
                
                completionHandler(nil, errorMessage)
            }
        }
    }
}
