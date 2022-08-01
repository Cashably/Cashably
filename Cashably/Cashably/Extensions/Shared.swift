//
//  UserDefaults.swift
//  Cashably
//
//  Created by apollo on 7/25/22.
//

import Foundation

class Shared{
    static func storeLoan(loan: [String: Any]) {
        let data = NSKeyedArchiver.archivedData(withRootObject: loan)
        UserDefaults.standard.set(data, forKey: "acceptedLoan")
        UserDefaults.standard.synchronize()
    }
    
    static func getLoan() -> LoanModel {
        let data = UserDefaults.standard.object(forKey: "acceptedLoan")
        let objLoan = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! [String: Any]
        let loan = LoanModel(fromDictionary: objLoan)
        return loan
    }
    
    static func storeAcceptedLoan(loan: Data) {
        UserDefaults.standard.set(loan, forKey: "acceptedLoan")
    }
    
    static func getAcceptedLoan() -> LoanResponse {
        let decoded  = UserDefaults.standard.object(forKey: "acceptedLoan") as! Data
        let decoder = JSONDecoder()
        let loan = try! decoder.decode(LoanResponse.self, from: decoded)
        return loan
    }
    
    static func storeUserToken(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    static func getUserToken() -> String {
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
    
    static func completeUserProfile(status: Bool) {
        UserDefaults.standard.set(status, forKey: "completeUserProfile")
    }
    
    static func isCompletedUserProfile() -> Bool {
        return UserDefaults.standard.bool(forKey: "completeUserProfile")
    }
}
