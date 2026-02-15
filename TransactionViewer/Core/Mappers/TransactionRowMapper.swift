//
//  TransactionRowMapper.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 15/02/26.
//

import Foundation
import SwiftUI
protocol TransactionRowMapping {
    func map(_ transaction: Transaction) -> TransactionRowUIModel
}

struct TransactionRowMapper: TransactionRowMapping {
    
     func map(_ transaction: Transaction) -> TransactionRowUIModel {
        
        TransactionRowUIModel(
            id: transaction.id,
            merchantName: transaction.merchantName,
            description: transaction.description ?? "",
            formattedAmount: AppCurrencyFormatter.string(from: transaction.amount),
            iconColor: iconColor(for: transaction.type),
            formattedDate: AppDateFormatter.display.string(from: transaction.postedDate),
            fromAccount: transaction.fromAccount,
            maskedCardNumber: CardMasking.masked(transaction.fromCardNumber)
        )
    }
    
    private func iconColor(for type: TransactionType) -> Color {
        switch type {
        case .debit:
            return .red
        case .credit:
            return .green
        }
    }
}
