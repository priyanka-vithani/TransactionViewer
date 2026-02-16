//
//  FormatterTests.swift
//  TransactionViewerTests
//
//  Created by Priyanka Vithani on 15/02/26.
//

import XCTest
@testable import TransactionViewer

final class FormatterTests: XCTestCase {
    
    /// TC-10
    /// Verifies standard 16-digit card numbers are masked
    /// to show only the last four digits.
    /// Expected format: "**** 8012".

    func test_TC10_standard16DigitMasking() {
        let result = CardMasking.masked("4537350001688012")
        XCTAssertEqual(result, "**** 8012")
    }

    /// TC-11
    /// Ensures short card numbers are fully masked
    /// without exposing any digits.

    func test_TC11_shortCardMasking() {
        let result = CardMasking.masked("123")
        XCTAssertEqual(result, "***")
    }

    /// TC-12
    /// Confirms leading/trailing whitespace is trimmed
    /// before applying masking logic.

    func test_TC12_whitespaceTrimHandling() {
        let result = CardMasking.masked(" 4537350001688012 ")
        XCTAssertEqual(result, "**** 8012")
    }

}
