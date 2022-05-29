//
//  User.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 31/03/2022.
//

import Foundation
import UIKit

struct User: Decodable {
    
    var id: String
    var firstName: String
    var lastName: String
    var picture: String?
    var phone: String?
    var email: String?
    var gender: String?
    var location: Location?
}
