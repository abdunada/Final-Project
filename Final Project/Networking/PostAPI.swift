//
//  PostAPI.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 27/04/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostAPI: API {
    
    // MARK: - Get All Post
    static func getAllPosts(page: Int, tag: String? , completionHandler: @escaping ([Post], Int) -> ()) {
        
        // MARK: - Get Response API
        var url = "\(baseURL)/post"
       
        if let tag = tag?.trimmingCharacters(in: .whitespaces) {
            url = "\(baseURL)/tag/\(tag)/post"
        }
        
        let parms = [
            "page": "\(page)",
            "limit": "5"
        ]
        AF.request(url, parameters: parms, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseJSON { response in
            
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let total = jsonData["total"].intValue
            
            let decoder = JSONDecoder()
            do {
                let posts = try decoder.decode([Post].self, from: data.rawData())
                completionHandler(posts, total)
            } catch let error {
                print(error)
            }
        }
    }
    
    // MARK: - Add New Post
    static func addNewPost(text: String, userId: String, completionHandler: @escaping () -> ()) {
        
        // MARK: - Get Response API
        let url = "\(baseURL)/post/create"
        let params = [
            "text" : text,
            "owner" : userId
        ]
        // MARK: - loaderIndicatorView
        AF.request(url, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            
            switch response.result {
                // MARK: - Success Response
            case .success:
                
                completionHandler()
                
                // MARK: - Failure Response
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Comment
    // MARK: - Get Comment
    static func getComment(id: String,completionHandler: @escaping ([Comment]) -> ()) {
        
        // MARK: - Get Response API
        let url = "\(baseURL)/post/\(id)/comment"
        
        // MARK: - loaderIndicatorView
        AF.request(url, headers: headers).responseJSON { response in
            
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do {
                let comments = try decoder.decode([Comment].self, from: data.rawData())
                completionHandler(comments)
            } catch let error {
                print(error)
            }
        }
    }
    
    // MARK: - Create Comment
    static func addNewCommentToPost(postId: String, userId: String, message: String , completionHandler: @escaping () -> ()) {
        
        // MARK: - Get Response API
        let url = "\(baseURL)/comment/create"
        let params = [
            "post" : postId,
            "owner" : userId,
            "message" : message
        ]
        // MARK: - loaderIndicatorView
        AF.request(url, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            
            switch response.result {
                // MARK: - Success Response
            case .success:
                
                completionHandler()
                
                // MARK: - Failure Response
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Tags
    // MARK: - Get All Tags
    static func getAllTags(completionHandler: @escaping ([String]) -> ()) {
        
        // MARK: - Get Response API
        let url = "\(baseURL)/tag"
        
        AF.request(url, headers: headers).responseJSON { response in
            
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do {
                let tags = try decoder.decode([String].self, from: data.rawData())
                completionHandler(tags )
            } catch let error {
                print(error)
            }
        }
    }
}
