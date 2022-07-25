//
//  UserDefaults.swift
//  Cashably
//
//  Created by apollo on 7/25/22.
//

import Foundation

class Shared{
    static func storeAcceptedLoan(loan: Data) {
        UserDefaults.standard.set(loan, forKey: "acceptedLoan")
    }
    
    static func getAcceptedLoan() -> LoanResponse {
        let decoded  = UserDefaults.standard.object(forKey: "acceptedLoan") as! Data
        let decoder = JSONDecoder()
        let loan = try! decoder.decode(LoanResponse.self, from: decoded)
        return loan
    }
}
