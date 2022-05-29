//
//  Comment.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 21/04/2022.
//

import Foundation
import UIKit

struct Comment: Decodable {
  
    var id: String
    var message: String
    var owner: User
}
