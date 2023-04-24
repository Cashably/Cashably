//
//  UserDefaults.swift
//  Cashably
//
//  Created by apollo on 7/25/22.
//

import Foundation

class Shared{
    
    static func storeUserToken(token: String) {
//        var user  = getUser1()
//        user["token"] = token
//        storeUser(user: user)
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    static func getUserToken() -> String {
//        let user  = getUser()
//        return user.token ?? ""
        return UserDefaults.standard.string(forKey: "token") ?? ""
    }
    
    static func storeForgotToken(token: String) {
        UserDefaults.standard.set(token, forKey: "forgot_token")
    }
    
    static func getForgotToken() -> String {
        return UserDefaults.standard.string(forKey: "forgot_token") ?? ""
    }
    
    static func storeUser(user: [String: Any]) {
        let data = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.standard.set(data, forKey: "user")
        UserDefaults.standard.synchronize()
    }
    
    static func getUser() -> UserModel {
        
        let data = UserDefaults.standard.object(forKey: "user")
            
        let objUser = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! [String: Any]
        let user = UserModel(fromDictionary: objUser)
        return user
    }
    
    static func getUser1() -> [String: Any] {
        
        let data = UserDefaults.standard.object(forKey: "user")
        let objUser = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! [String: Any]
        return objUser
    }
    
    static func completeUserProfile(status: Bool) {
        var user = getUser1()
        user["isCompletedProfile"] = status
        storeUser(user: user)
//        UserDefaults.standard.set(status, forKey: "completeUserProfile")
    }
    
    static func isCompletedUserProfile() -> Bool {
        let user = getUser()
        return user.isCompletedProfile
//        return UserDefaults.standard.bool(forKey: "completeUserProfile")
    }
    
    static func storeCards(cards: [[String: Any]]) {
        var user = getUser1()
        user["cards"] = cards
        storeUser(user: user)
    }
    
    static func getCards() -> [Card] {
        let user = getUser()
        return user.cards
    }
    
    static func subscribed(status: Bool) {
        var user = getUser1()
        user["subscribed"] = status
        storeUser(user: user)
    }
}
