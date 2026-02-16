//
//  TransactionRowUIModel.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 13/02/26.
//

import Foundation
import SwiftUI
// MARK: - Transaction Row UI Model
struct TransactionRowUIModel: Identifiable {
    // MARK: - Properties
    let id: String
    let merchantName: String
    let description: String
    let formattedAmount: String
    let iconColor: Color
    let formattedDate: String
    let fromAccount: String
    let maskedCardNumber: String
}
