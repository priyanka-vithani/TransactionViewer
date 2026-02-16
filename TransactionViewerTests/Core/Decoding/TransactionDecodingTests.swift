//
//  TransactionDecodingTests.swift
//  TransactionViewerTests
//
//  Created by Priyanka Vithani on 15/02/26.
//

import XCTest
@testable import TransactionViewer

@MainActor
final class TransactionDecodingTests: XCTestCase {
    /// TC-01
    /// Verifies that a valid transaction-list.json file
    /// decodes successfully into TransactionResponse.
    /// Ensures:
    /// - All transactions are parsed
    /// - Transaction types map correctly to enum
    /// - postedDate is decoded using expected date strategy.
    func test_TC01_decodeValidJSON_success() throws {
        // Given
        let bundle = Bundle(for: Self.self)
        guard let url = bundle.url(forResource: "transaction-list", withExtension: "json") else {
            XCTFail("Missing JSON file")
            return
        }

        let data = try Data(contentsOf: url)

        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        decoder.dateDecodingStrategy = .formatted(formatter)

        // When
        let response = try decoder.decode(TransactionResponse.self, from: data)

        // Then
        XCTAssertEqual(response.transactions.count, 33)
        XCTAssertEqual(response.transactions.first?.type, .debit)
        XCTAssertEqual(response.transactions.last?.type, .credit)

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day],
                                                 from: response.transactions.first!.postedDate)

        XCTAssertEqual(components.year, 2021)
        XCTAssertEqual(components.month, 5)
        XCTAssertEqual(components.day, 31)
    }
    
    /// TC-02
    /// Ensures that decoding fails when the date format
    /// does not match the configured DateFormatter ("yyyy-MM-dd").
    /// Confirms dateDecodingStrategy is strictly enforced.

    func test_TC02_invalidDateFormat_shouldThrow() {
        let json = """
        {
          "transactions": [{
            "key": "1",
            "transaction_type": "DEBIT",
            "merchant_name": "Test",
            "amount": { "value": 10, "currency": "CAD" },
            "posted_date": "31-05-2021",
            "from_account": "Visa",
            "from_card_number": "1234"
          }]
        }
        """

        let data = Data(json.utf8)

        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        decoder.dateDecodingStrategy = .formatted(formatter)

        XCTAssertThrowsError(try decoder.decode(TransactionResponse.self, from: data))
    }
    
    /// TC-03
    /// Validates that a missing "description" field
    /// does not break decoding and is safely mapped as nil.
    /// Confirms optional handling in Transaction model.

    func test_TC03_missingDescription_shouldBeNil() throws {
        let bundle = Bundle(for: Self.self)
        let url = bundle.url(forResource: "transaction-list", withExtension: "json")!
        let data = try Data(contentsOf: url)

        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        decoder.dateDecodingStrategy = .formatted(formatter)

        let response = try decoder.decode(TransactionResponse.self, from: data)

        let secondTransaction = response.transactions[1]

        XCTAssertNil(secondTransaction.description)
    }

}
