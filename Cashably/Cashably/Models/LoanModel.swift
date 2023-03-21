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
    var donate: Double!
    var approved: Double!
    var snoozeFee: Double!
    var instantFee: Double!
    var snooze: Int!
    var dueDate: String!
    var to: String!
    var company: String!
    var createdAtTimestamp: Int64!
    var dueDateTimestamp: Int64!
    var nextDueDate: String!
    
    init(fromDictionary dictionary: [String: Any]) {
        
        amount = dictionary["amount"] as? Double
        total = dictionary["total"] as? Double
        donate = dictionary["donate"] as? Double
        approved = dictionary["approved"] as? Double
        snoozeFee = dictionary["snoozeFee"] as? Double
        instantFee = dictionary["instantFee"] as? Double
        dueDate = dictionary["dueDate"] as? String
        snooze = dictionary["snooze"] as? Int
        to = dictionary["to"] as? String
        company = dictionary["company"] as? String
        createdAtTimestamp = dictionary["createdAtTimestamp"] as? Int64
        dueDateTimestamp = dictionary["dueDateTimestamp"] as? Int64
        nextDueDate = dictionary["nextDueDate"] as? String
    }
    
    
}
