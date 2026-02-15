//
//  TransactionRowMapperTests.swift
//  TransactionViewerTests
//
//  Created by Priyanka Vithani on 15/02/26.
//

import XCTest
@testable import TransactionViewer
internal import SwiftUI
final class TransactionMapperTests: XCTestCase {
    func test_TC13_debitTransactionMapping() {
        let transaction = MockTransactionFactory.make(type: .debit)

        let mapper = TransactionRowMapper()
        let ui = mapper.map(transaction)

        XCTAssertEqual(ui.iconColor.description, Color.red.description)
        XCTAssertEqual(ui.maskedCardNumber, "**** 8012")
    }

    func test_TC14_creditTransactionMapping() {
        let transaction = MockTransactionFactory.make(type: .credit)

        let mapper = TransactionRowMapper()
        let ui = mapper.map(transaction)

        XCTAssertEqual(ui.iconColor, Color.green)
    }
    func test_TC15_creditIconColorDetail() {
        let mapper = TransactionDetailMapper()
        let ui = mapper.map(MockTransactionFactory.make(type: .credit))
        XCTAssertEqual(ui.iconColor, Color.green)
    }

    func test_TC16_debitIconColorDetail() {
        let mapper = TransactionDetailMapper()
        let ui = mapper.map(MockTransactionFactory.make(type: .debit))
        XCTAssertEqual(ui.iconColor, Color.red)
    }

    func test_TC17_formattedFromAccountContainsMaskedDigits() {
        let mapper = TransactionDetailMapper()
        let ui = mapper.map(MockTransactionFactory.make(type: .debit))

        XCTAssertTrue(ui.formattedFromAccount.description.contains("**** 8012"))
    }
    

}
