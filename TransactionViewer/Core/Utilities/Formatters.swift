//
//  Formatters.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 14/02/26.
//

import Foundation

// MARK: - Date Formatter

enum AppDateFormatter {
    static let display: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

// MARK: - Currency Formatter

enum AppCurrencyFormatter {
    
    // MARK: - Cache
    
    private static var cache: [String: NumberFormatter] = [:]
    
    // MARK: - Public API
    
    static func string(from amount: Amount) -> String {
        let formatter = formatter(for: amount.currency)
        return formatter.string(from: NSNumber(value: amount.value))
            ?? "\(amount.value)"
    }
    
    // MARK: - Private Helpers
    
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

// MARK: - Card Masking Utility

enum CardMasking {
    
    // MARK: - Public API
    
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
    
    static func getLastNDigitOfCardNumber(
        _ cardNumber: String,
        visibleDigits: Int = 4
    ) -> String {
        let trimmed = cardNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastDigits = trimmed.suffix(visibleDigits)
        return "\(lastDigits)"
    }
}
