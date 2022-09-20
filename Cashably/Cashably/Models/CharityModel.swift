//
//  CharityModel.swift
//  Cashably
//
//  Created by apollo on 9/19/22.
//

import Foundation

struct CharityModel {
    let id: Int!
    let name: String!
    let logo: String!
    
    init(fromDictionary dictionary: [String: Any]) {
        
        name = dictionary["name"] as? String
        logo = dictionary["logo"] as? String
        id = dictionary["id"] as? Int
    }
}
