//
//  Post.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 28/03/2022.
//

import Foundation
import UIKit

struct Post: Decodable {
    
    var id: String
    var image: String
    var likes: Int
    var text: String
    var owner: User
    var tags: [String]?
}
