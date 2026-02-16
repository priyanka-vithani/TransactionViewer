//
//  TransactionRepositoryTests.swift
//  TransactionViewerTests
//
//  Created by Priyanka Vithani on 15/02/26.
//

import XCTest
import XCTest
@testable import TransactionViewer

@MainActor
final class TransactionRepositoryTests: XCTestCase {
    
    /// TC-04
    /// Verifies that TransactionRepository returns
    /// successfully decoded transactions when the network layer succeeds.
    /// Ensures correct propagation of decoded data.

    func test_TC04_repositoryReturnsTransactions() async throws {
        let mock = MockNetwork()

        let sample = TransactionResponse(transactions: [
            Transaction(id: "1",
                        type: .debit,
                        merchantName: "Test",
                        description: nil,
                        amount: Amount(value: 10, currency: "CAD"),
                        postedDate: Date(),
                        fromAccount: "Visa",
                        fromCardNumber: "1234")
        ])

        mock.result = .success(sample)

        let repo = TransactionRepository(network: mock)

        let transactions = try await repo.fetchTransactions()

        XCTAssertEqual(transactions.count, 1)
    }
    
    /// TC-05
    /// Ensures that errors from the network layer
    /// are propagated without being swallowed.
    /// Confirms repository does not silently fail.

    func test_TC05_repositoryPropagatesError() async {
        let mock = MockNetwork()
        mock.result = .failure(JSONError.fileNotFound("file"))

        let repo = TransactionRepository(network: mock)

        do {
            _ = try await repo.fetchTransactions()
            XCTFail("Expected error")
        } catch {
            XCTAssertTrue(error is JSONError)
        }
    }
    
    /// TC-06
    /// Validates that task cancellation is respected.
    /// Ensures fetchTransactions does not proceed
    /// when the parent task has been cancelled.

    func test_TC06_taskCancellationStopsExecution() async {
        let mock = MockNetwork()

        mock.result = .success(TransactionResponse(transactions: []))

        let repo = TransactionRepository(network: mock)

        let task = Task {
            try await repo.fetchTransactions()
        }

        task.cancel()

        do {
            _ = try await task.value
            XCTFail("Expected cancellation")
        } catch {
            XCTAssertTrue(error is CancellationError)
        }
    }
    
    /// TC-07
    /// Verifies currency formatting for CAD values.
    /// Ensures NumberFormatter returns a properly
    /// formatted currency string based on locale.

    func test_TC07_currencyFormattingCAD() {
        let amount = Amount(value: 200.2, currency: "CAD")

        let result = AppCurrencyFormatter.string(from: amount)

        XCTAssertTrue(result.contains("200"))
    }
    
    /// TC-08
    /// Ensures unknown currency codes do not crash the formatter.
    /// Confirms fallback behavior returns a safe string representation.

    func test_TC08_unknownCurrencyFallback() {
        let amount = Amount(value: 10, currency: "XYZ")

        let result = AppCurrencyFormatter.string(from: amount)

        XCTAssertFalse(result.isEmpty)
    }
    
    /// TC-09
    /// Validates display date formatting using AppDateFormatter.
    /// Ensures consistent medium-style date output.

    func test_TC09_dateDisplayFormatting() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let date = formatter.date(from: "2021-05-31")!

        let display = AppDateFormatter.display.string(from: date)

        XCTAssertTrue(display.contains("2021"))
    }


}
