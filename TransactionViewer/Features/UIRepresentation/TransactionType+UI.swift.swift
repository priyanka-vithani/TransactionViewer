//
//  TransactionType+UI.swift.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 15/02/26.
//
import SwiftUI

// MARK: - UI Extensions for TransactionType

extension TransactionType {

    var iconColor: Color {
        switch self {
        case .debit: return .red
        case .credit: return .green
        }
    }
}
