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
    var email: String!
    var dob: String!
    var SSN4: String!
    var subscribed: Bool!
    var token: String!
    var isCompletedProfile: Bool!
    var cards: [Card]!
    
    init(fromDictionary dictionary: [String: Any]) {
        
        fullName = dictionary["name"] as? String
        phone = dictionary["phone"] as? String
        email = dictionary["email"] as? String
        dob = dictionary["dob"] as? String
        SSN4 = dictionary["ssn"] as? String
        token = dictionary["token"] as? String
        isCompletedProfile = dictionary["isCompletedProfile"] as? Bool
        if let subscribed = dictionary["subscribed"] as? Bool {
            self.subscribed = subscribed
        } else {
            self.subscribed = false
        }
        cards = [Card]()
        if let tempCards = dictionary["cards"] as? [[String: Any]] {
            for item in tempCards {
                cards.append(Card(fromDictionary: item))
            }
        }
        
    }
}
