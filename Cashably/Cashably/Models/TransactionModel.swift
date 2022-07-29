//
//  TransactionModel.swift
//  Cashably
//
//  Created by apollo on 7/29/22.
//

import Foundation

struct TransactionModel {
    let amount: String!
    let type: String!
    let company: String!
    let createdAtTimestamp: Int64!
    let createdAt: String!
    
    init(fromDictionary dictionary: [String: Any]) {
        
        amount = dictionary["amount"] as? String
        type = dictionary["type"] as? String
        company = dictionary["company"] as? String
        createdAt = dictionary["createdAt"] as? String
        createdAtTimestamp = dictionary["createdAtTimestamp"] as? Int64
    }
}
