//
//  String+Extension.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 01/02/26.
//

import Foundation

extension String {
    // Converts string date ("yyyy-MM-dd") to readable format using device locale
    func toReadableDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .medium
        outputFormatter.timeStyle = .none
        outputFormatter.locale = Locale.current
        
        if let date = inputFormatter.date(from: self) {
            return outputFormatter.string(from: date)
        } else {
            return self // fallback in case of invalid date
        }
    }
    // Formats credit/debit card numbers securely (mask middle digits)
    func formatSecureCardNumber() -> String {
        let cleaned = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "••••"
        guard cleaned.count >= 16 else { return self } // fallback if not 16 digits
        
        let firstFour = cleaned.prefix(4)
        let lastFour = cleaned.suffix(4)
        return "\(firstFour) \(mask) \(mask) \(lastFour)"
    }
}
