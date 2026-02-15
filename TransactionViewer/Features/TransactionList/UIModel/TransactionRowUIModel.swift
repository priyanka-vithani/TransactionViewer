//
//  TransactionRowUIModel.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 13/02/26.
//

import Foundation
import SwiftUI
struct TransactionRowUIModel: Identifiable {
    let id: String
    let merchantName: String
    let description: String
    let formattedAmount: String
    let iconColor: Color
    let formattedDate: String
    let fromAccount: String
    let maskedCardNumber: String
}
