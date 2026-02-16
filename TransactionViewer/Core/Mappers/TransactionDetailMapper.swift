//
//  TransactionDetailMapper.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 15/02/26.
//

import Foundation
import SwiftUI

// MARK: - Detail Mapping Protocol
protocol TransactionDetailMapping {
    func map(_ transaction: Transaction) -> TransactionDetailUIModel
}

// MARK: - Detail Mapper
struct TransactionDetailMapper: TransactionDetailMapping {
    // MARK: - Public Mapping
     func map(_ transaction: Transaction) -> TransactionDetailUIModel {
         TransactionDetailUIModel(
            title: transaction.merchantName,
            iconColor: transaction.type.iconColor,
            formattedFromAccount: formattedFromAccount(transaction: transaction),
            formattedAmount: AppCurrencyFormatter.string(from: transaction.amount))
    }
    
    // MARK: - Private Helpers
    private func formattedFromAccount(transaction:Transaction) -> AttributedString {
        var text = AttributedString(transaction.fromAccount)
        
        let masked = CardMasking.masked(transaction.fromCardNumber)
        var suffix = AttributedString(" (\(masked))")
        suffix.foregroundColor = .gray
        
        text += suffix
        return text
    }
}
