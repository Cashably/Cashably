//
//  ResponseType.swift
//  Cashably
//
//  Created by apollo on 7/21/22.
//

import Foundation

struct ProfileResponse: Decodable {
    let status: Bool
    let enableLogout: Bool
    let message: String
}

struct StatusResponse: Decodable {
    let status: Bool
}

struct AmountResponse: Decodable {
    let amount: Double
}

struct StringDataResponse: Decodable {
    let status: Bool
    let data: String
}

struct LoanResponse: Decodable {
    let amount: Double
    let dueDate: String
    let to: String
    let dueDateTimestamp: Int64
}
