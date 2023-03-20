//
//  Subscribe.swift
//  Cashably
//
//  Created by apollo on 3/20/23.
//

import Foundation

struct Subscribe {
    var price: Double!
    var validate: String!
    
    init(fromDictionary dictionary: [String: Any]) {
        
        price = dictionary["price"] as? Double
        validate = dictionary["validate"] as? String
    }
    
    
}
