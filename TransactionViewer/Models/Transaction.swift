//
//  Transaction.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 30/01/26.
//

import Foundation
struct TransactionResponse:Decodable{
    let transactions:[Transaction]
}
enum TransactionType: String, Decodable {
    case debit = "DEBIT"
    case credit = "CREDIT"
}
struct Amount: Decodable {
    let value: Double
    let currency: String
}
struct Transaction: Decodable, Identifiable {
    let id: String
    let type: TransactionType
    let merchantName: String
    let description: String?
    let amount: Amount
    let postedDate: String
    let fromAccount: String
    let fromCardNumber: String

    enum CodingKeys: String, CodingKey {
        case id = "key"
        case type = "transaction_type"
        case merchantName = "merchant_name"
        case description
        case amount
        case postedDate = "posted_date"
        case fromAccount = "from_account"
        case fromCardNumber = "from_card_number"
    }
}
