//
//  WithdrawModel.swift
//  Cashably
//
//  Created by apollo on 7/28/22.
//

import Foundation

struct WithdrawModel {
    let depositAmount: Double!
    let totalAmount: Double!
    let dueDate: String!
    let to: String!
    
    init(fromDictionary dictionary: [String: Any]) {
        
        depositAmount = dictionary["depositAmount"] as? Double
        totalAmount = dictionary["totalAmount"] as? Double
        dueDate = dictionary["dueDate"] as? String
        to = dictionary["to"] as? String
    }
}
