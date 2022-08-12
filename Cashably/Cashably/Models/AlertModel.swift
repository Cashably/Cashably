//
//  AlertModel.swift
//  Cashably
//
//  Created by apollo on 8/11/22.
//

import Foundation

struct AlertModel {
    var latest: Bool!
    var transactions: Bool!
    var email: Bool!
    var sms: Bool!
    
    init(fromDictionary dictionary: [String: Any]) {
        
        latest = dictionary["latest"] as? Bool
        transactions = dictionary["transactions"] as? Bool
        email = dictionary["email"] as? Bool
        sms = dictionary["sms"] as? Bool
        
    }
    
    
}
