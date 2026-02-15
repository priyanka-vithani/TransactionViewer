//
//  Formatters.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 14/02/26.
//

import Foundation

enum AppDateFormatter {
    static let display: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}
enum AppCurrencyFormatter {
    
    private static var cache: [String: NumberFormatter] = [:]
    
    static func string(from amount: Amount) -> String {
        let formatter = formatter(for: amount.currency)
        return formatter.string(from: NSNumber(value: amount.value))
            ?? "\(amount.value)"
    }
    
    private static func formatter(for currency: String) -> NumberFormatter {
        if let existing = cache[currency] {
            return existing
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        formatter.locale = Locale.current
        
        cache[currency] = formatter
        return formatter
    }
}

enum CardMasking {
    
    static func masked(
        _ cardNumber: String,
        visibleDigits: Int = 4,
        maskSymbol: String = "*"
    ) -> String {
        
        let trimmed = cardNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmed.count > visibleDigits else {
            return String(repeating: maskSymbol, count: trimmed.count)
        }
        
        let lastDigits = trimmed.suffix(visibleDigits)
        let maskedPart = String(repeating: maskSymbol, count: 4)
        
        return "\(maskedPart) \(lastDigits)"
    }
}
