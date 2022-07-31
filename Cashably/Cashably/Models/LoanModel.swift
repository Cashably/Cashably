//
//  LoanModel.swift
//  Cashably
//
//  Created by apollo on 7/28/22.
//

import Foundation

struct LoanModel {
    var amount: Double!
    var total: Double!
    var snoozeFee: Double!
    var snooze: Int!
    var dueDate: String!
    var to: String!
    var createdAtTimestamp: Int64!
    var dueDateTimestamp: Int64!
    var nextDueDate: String!
    
    init(fromDictionary dictionary: [String: Any]) {
        
        amount = dictionary["amount"] as? Double
        total = dictionary["total"] as? Double
        snoozeFee = dictionary["snoozeFee"] as? Double
        dueDate = dictionary["dueDate"] as? String
        snooze = dictionary["snooze"] as? Int
        to = dictionary["to"] as? String
        createdAtTimestamp = dictionary["createdAtTimestamp"] as? Int64
        dueDateTimestamp = dictionary["dueDateTimestamp"] as? Int64
        nextDueDate = dictionary["nextDueDate"] as? String
    }
    
    
}
