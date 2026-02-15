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

    private let uiModel: TransactionDetailUIModel

    init(transaction: Transaction,
         mapper: TransactionDetailMapping = TransactionDetailMapper()) {

        self.uiModel = mapper.map(transaction)
    }

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


