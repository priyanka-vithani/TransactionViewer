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
    
    /// TC-13
    /// Validates debit transaction mapping to UI model.
    /// Ensures:
    /// - Icon color is red
    /// - Card number is masked
    /// - Formatting logic is applied.

    func test_TC13_debitTransactionMapping() {
        let transaction = MockTransactionFactory.make(type: .debit)

        let mapper = TransactionRowMapper()
        let ui = mapper.map(transaction)

        XCTAssertEqual(ui.iconColor.description, Color.red.description)
        XCTAssertEqual(ui.maskedCardNumber, "**** 8012")
    }

    /// TC-14
    /// Validates credit transaction mapping to UI model.
    /// Ensures icon color is green.

    func test_TC14_creditTransactionMapping() {
        let transaction = MockTransactionFactory.make(type: .credit)

        let mapper = TransactionRowMapper()
        let ui = mapper.map(transaction)

        XCTAssertEqual(ui.iconColor, Color.green)
    }
    
    /// TC-15
    /// Ensures credit transactions map to green icon color
    /// in the detail UI model.

    func test_TC15_creditIconColorDetail() {
        let mapper = TransactionDetailMapper()
        let ui = mapper.map(MockTransactionFactory.make(type: .credit))
        XCTAssertEqual(ui.iconColor, Color.green)
    }

    /// TC-16
    /// Ensures debit transactions map to red icon color
    /// in the detail UI model.

    func test_TC16_debitIconColorDetail() {
        let mapper = TransactionDetailMapper()
        let ui = mapper.map(MockTransactionFactory.make(type: .debit))
        XCTAssertEqual(ui.iconColor, Color.red)
    }
    
    /// TC-17
    /// Validates formatted "From Account" text contains
    /// correctly masked card digits and combined account name.
    /// Confirms mapping of attributed string content.


    func test_TC17_formattedFromAccountContainsMaskedDigits() {
        let mapper = TransactionDetailMapper()
        let ui = mapper.map(MockTransactionFactory.make(type: .debit))

        XCTAssertTrue(ui.formattedFromAccount.description.contains("**** 8012"))
    }
    

}
