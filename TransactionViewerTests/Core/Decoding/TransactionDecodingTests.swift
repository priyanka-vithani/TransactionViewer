//
//  TransactionDecodingTests.swift
//  TransactionViewerTests
//
//  Created by Priyanka Vithani on 15/02/26.
//

import XCTest
@testable import TransactionViewer

@MainActor
final class DecodingTests: XCTestCase {

    func testTransactionDecodesDateCorrectly() throws {
        let json = """
        {
            "transactions": [
                {
                    "key": "1",
                    "transaction_type": "DEBIT",
                    "merchant_name": "Test",
                    "description": "Desc",
                    "amount": { "value": 10.0, "currency": "CAD" },
                    "posted_date": "2021-05-31",
                    "from_account": "Visa",
                    "from_card_number": "1234567812345678"
                }
            ]
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        decoder.dateDecodingStrategy = .formatted(formatter)

        let response = try decoder.decode(TransactionResponse.self, from: json)

        XCTAssertEqual(response.transactions.count, 1)
    }
}

