//
//  MockTransactionFactory.swift
//  TransactionViewerTests
//
//  Created by Priyanka Vithani on 15/02/26.
//

import Foundation
@testable import TransactionViewer

enum MockTransactionFactory {

    static func make(
        id: String = "1",
        type: TransactionType = .debit,
        merchantName: String = "Test Merchant",
        description: String? = "Test Description",
        amount: Amount = Amount(value: 10, currency: "CAD"),
        postedDate: Date = Date(),
        fromAccount: String = "Momentum Regular Visa",
        fromCardNumber: String = "4537350001688012"
    ) -> Transaction {

        return Transaction(
            id: id,
            type: type,
            merchantName: merchantName,
            description: description,
            amount: amount,
            postedDate: postedDate,
            fromAccount: fromAccount,
            fromCardNumber: fromCardNumber
        )
    }
}
