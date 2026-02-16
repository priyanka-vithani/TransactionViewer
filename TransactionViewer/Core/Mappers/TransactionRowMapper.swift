//
//  TransactionRowMapper.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 15/02/26.
//

import Foundation
import SwiftUI

// MARK: - Row Mapping Protocol
protocol TransactionRowMapping {
    func map(_ transaction: Transaction) -> TransactionRowUIModel
}
// MARK: - Row Mapper
// Converts domain model into UI-specific representation.
// Keeps formatting and UI logic out of View and ViewModel.
struct TransactionRowMapper: TransactionRowMapping {
    // MARK: - Public Mapping
     func map(_ transaction: Transaction) -> TransactionRowUIModel {
        TransactionRowUIModel(
            id: transaction.id,
            merchantName: transaction.merchantName,
            description: transaction.description ?? "",
            formattedAmount: AppCurrencyFormatter.string(from: transaction.amount),
            iconColor: transaction.type.iconColor,
            formattedDate: AppDateFormatter.display.string(from: transaction.postedDate),
            fromAccount: transaction.fromAccount,
            maskedCardNumber: CardMasking.masked(transaction.fromCardNumber)
        )
    }
}
