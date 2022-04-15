//
//  Transaction.swift
//  Expensum
//
//  Created by Chris James on 04/04/2022.
//

import Foundation

struct TransactionsResponse: Codable {
    let transactions: [Transaction]?
    let count: Int?
    let income: String?
    let expense: String?
    let balance: String?
    let success: Bool
    let message: String
}

struct TransactionResponse: Codable {
    let transaction: Transaction?
    let success: Bool
    let message: String
}

struct Transaction: Codable {
    let id: Int
    let cat_id: Int
    let description: String
    let type: String
    let amount: String
    let category: Category?
    let trans_date: String
    let createdAt: String
    let updatedAt: String
    
//    init(json: [String:Any]) {
//        id = json["id"] as! Int
//        cat_id = json["cat_id"] as! Int
//        description = json["description"] as! String
//        type = json["type"] as! String
//        amount = json["amount"] as! String
//        category = json["category"] as! Category
//        trans_date = json["trans_date"] as! String
//        createdAt = json["createdAt"] as! String
//        updatedAt = json["updatedAt"] as! String
//    }
}
