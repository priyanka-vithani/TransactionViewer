//
//  TransactionDetailViewModel.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 13/02/26.
//

import Foundation
import SwiftUI
import Combine

final class TransactionDetailViewModel: ObservableObject {
    private let transaction: Transaction
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    var title: String {
        transaction.type.displayTitle
    }
    
    var iconColor: Color {
        transaction.type.iconColor
    }
    
    var formattedFromAccount: AttributedString {
        var text = AttributedString(transaction.fromAccount)
        
        let masked = CardMasking.masked(transaction.fromCardNumber)
        var suffix = AttributedString(" (\(masked))")
        suffix.foregroundColor = .gray
        
        text += suffix
        return text
    }
    
    var formattedAmount: String {
        AppCurrencyFormatter.string(from: transaction.amount)
    }
}

