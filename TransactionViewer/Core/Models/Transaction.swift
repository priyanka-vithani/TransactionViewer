//
//  Transaction.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 11/02/26.
//

import Foundation

// MARK: - Response Model

struct TransactionResponse: Decodable {
    let transactions: [Transaction]
}

// MARK: - Transaction Type

enum TransactionType: String, Decodable {
    case debit = "DEBIT"
    case credit = "CREDIT"
    
    var displayTitle: String {
        switch self {
        case .credit: return "Credit Transaction"
        case .debit: return "Debit Transaction"
        }
    }
}

// MARK: - Amount Model

struct Amount: Decodable, Hashable {
    let value: Double
    let currency: String
}

// MARK: - Transaction Model

struct Transaction: Decodable, Identifiable, Hashable {
    
    // MARK: - Properties
    
    let id: String
    let type: TransactionType
    let merchantName: String
    let description: String?
    let amount: Amount
    let postedDate: Date
    let fromAccount: String
    let fromCardNumber: String
    
    // MARK: - Coding Keys
    
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
    
    // MARK: - Equatable
    
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.id == rhs.id
    }
}
