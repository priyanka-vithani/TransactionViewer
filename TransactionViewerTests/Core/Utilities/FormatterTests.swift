//
//  FormatterTests.swift
//  TransactionViewerTests
//
//  Created by Priyanka Vithani on 15/02/26.
//

import XCTest
@testable import TransactionViewer

final class FormatterTests: XCTestCase {
    
    func test_TC10_standard16DigitMasking() {
        let result = CardMasking.masked("4537350001688012")
        XCTAssertEqual(result, "**** 8012")
    }

    func test_TC11_shortCardMasking() {
        let result = CardMasking.masked("123")
        XCTAssertEqual(result, "***")
    }

    func test_TC12_whitespaceTrimHandling() {
        let result = CardMasking.masked(" 4537350001688012 ")
        XCTAssertEqual(result, "**** 8012")
    }

}
