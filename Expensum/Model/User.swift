//
//  User.swift
//  Expensum
//
//  Created by Chris James on 06/04/2022.
//

import Foundation

struct LoginResponse: Codable {
    let user: User?
    let token: String?
    let success: Bool
    let message: String
}

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let createdAt: String
    let updatedAt: String
    
//    init(json: [String:Any]) {
//        id = json["id"] as! Int
//        name = json["name"] as! String
//        email = json["email"] as! String
//        createdAt = json["createdAt"] as! String
//        updatedAt = json["updatedAt"] as! String
//    }
}
