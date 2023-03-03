//
//  Card.swift
//  Cashably
//
//  Created by apollo on 3/3/23.
//

import Foundation

struct Card {
    var holderName: String!
    var cardNumber: String!
    var ccv: String!
    var expiredDay: String!
    
    init(fromDictionary dictionary: [String: Any]) {
        
        holderName = dictionary["holderName"] as? String
        cardNumber = dictionary["cardNumber"] as? String
        ccv = dictionary["ccv"] as? String
        expiredDay = dictionary["expiredDay"] as? String
    }
}
