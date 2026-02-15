//
//  TransactionDetailMapper.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 15/02/26.
//

import Foundation
import SwiftUI
protocol TransactionDetailMapping {
    func map(_ transaction: Transaction) -> TransactionDetailUIModel
}

struct TransactionDetailMapper: TransactionDetailMapping {
    
     func map(_ transaction: Transaction) -> TransactionDetailUIModel {
         
         TransactionDetailUIModel(
            title: transaction.merchantName,
            iconColor: iconColor(for: transaction.type),
            formattedFromAccount: formattedFromAccount(transaction: transaction),
            formattedAmount: AppCurrencyFormatter.string(from: transaction.amount))
    }
    private func formattedFromAccount(transaction:Transaction) -> AttributedString {
        var text = AttributedString(transaction.fromAccount)
        
        let masked = CardMasking.masked(transaction.fromCardNumber)
        var suffix = AttributedString(" (\(masked))")
        suffix.foregroundColor = .gray
        
        text += suffix
        return text
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
