//
//  TransactionDetailUIModel.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 13/02/26.
//

import Foundation
import SwiftUI

// MARK: - Transaction Detail UI Model

struct TransactionDetailUIModel {
    
    // MARK: - Properties
    
    let type: TransactionType
    let iconColor: Color
    let formattedFromAccount: AttributedString
    let formattedAmount: String
}
