//
//  Category.swift
//  Expensum
//
//  Created by Chris James on 04/04/2022.
//

import Foundation

struct CategoriesResponse: Codable {
    let categories: [Category]?
    let success: Bool
    let message: String
}

struct Category: Codable {
    let id: Int
    let name: String
    let createdAt: String
    let updatedAt: String
    
//    init(json: [String:Any]) {
//        id = json["id"] as! Int
//        name = json["name"] as! String
//        createdAt = json["createdAt"] as! String
//        updatedAt = json["updatedAt"] as! String
//    }
}
