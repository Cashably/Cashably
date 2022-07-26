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
    let total: Double
    let snoozeFee: Double
    let snooze: Int
    let dueDate: String
    let to: String
    let createdAtTimestamp: Int64
    let dueDateTimestamp: Int64
    let nextDueDate: String
}

struct MessageResponse: Decodable {
    let status: Bool
    let message: String
}

struct DataResponse: Decodable {
    let data: [TransactionResponse]
    let status: Bool
    let message: String
}

struct TransactionResponse: Decodable {
    let amount: String
    let type: String
    let company: String
    let createdAtTimestamp: Int64
    let createdAt: String
}

struct WithdrawResponse: Decodable {
    let data: WithdraW
    let status: Bool
    let message: String
}

struct WithdraW: Decodable {
    let depositAmount: Double
    let totalAmount: Double
    let dueDate: String
    let to: String
}
