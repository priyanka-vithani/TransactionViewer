//
//  TransactionDetailViewModel.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 13/02/26.
//

import Foundation
import SwiftUI
import Combine
// MARK: - Transaction Detail ViewModel
final class TransactionDetailViewModel: ObservableObject {
    // MARK: - Properties
    private let uiModel: TransactionDetailUIModel
    // MARK: - Initializer
    init(transaction: Transaction,
         mapper: TransactionDetailMapping = TransactionDetailMapper()) {

        self.uiModel = mapper.map(transaction)
    }
    // MARK: - Exposed UI Properties
    var title: String {
        uiModel.title
    }

    var iconColor: Color {
        uiModel.iconColor
    }

    var formattedFromAccount: AttributedString {
        uiModel.formattedFromAccount
    }

    var formattedAmount: String {
        uiModel.formattedAmount
    }
}


