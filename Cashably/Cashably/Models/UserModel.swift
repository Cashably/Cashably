//
//  UserModel.swift
//  Cashably
//
//  Created by apollo on 6/17/22.
//

import Foundation

struct UserModel {
    var fullName: String!
    var phone: String!
    var countryCode: String!
    var email: String!
    var dob: String!
    var SSN4: String!
    
    init(fromDictionary dictionary: [String: Any]) {
        
        fullName = dictionary["full_name"] as? String
        phone = dictionary["mobile"] as? String
        countryCode = dictionary["country_code"] as? String
        email = dictionary["email"] as? String
        dob = dictionary["dob"] as? String
        SSN4 = dictionary["SSN4"] as? String
        
    }
    
    
}
