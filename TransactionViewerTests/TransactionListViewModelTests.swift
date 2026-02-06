//
//  TransactionListViewModelTests.swift
//  TransactionViewerTests
//
//  Created by Priyanka Vithani on 01/02/26.
//

import XCTest
@testable import TransactionViewer

final class TransactionListViewModelTests: XCTestCase {
    
    // Tests successful fetch
    @MainActor
    func test_FetchTransaction_success_updateTransactions() async throws{
        
        //Arrange
        let mockService = MockTransactionService()
        mockService.shouldReturnTransaction = [Transaction(id: "kDk81_4xGkWW_vOVP_ExwK7GVUlzQ5YtYcuZARHuAQg=", type: .debit, merchantName: "Mb - Cash Advance To - 1785", description: "Bill payment", amount: Amount(value: 200.20, currency: "CAD"), postedDate: "2025-10-21", fromAccount: "Momentum Regular Visa", fromCardNumber: "4537350001688012")]
        
        let viewModel = TransactionListViewModel(service: mockService)
        
        // Act
        await viewModel.fetchTransactions()
        
        // Assert
        XCTAssertEqual(viewModel.transactions.count, 1)
        XCTAssertEqual(viewModel.transactions.first?.merchantName, "Mb - Cash Advance To - 1785")
        
    }
    
    // Tests failure scenario
    @MainActor
    func testFetchTransaction_failure_setsEmptyTransactions() async throws{
        // Arrange
        let mockService = MockTransactionService()
        mockService.errorToThrow = TransactionServiceError.decodingFailed(NSError(domain: "", code: 0, userInfo: nil))
        
        let viewModel = TransactionListViewModel(service: mockService)
        
        // Act
        await viewModel.fetchTransactions()
        
        // Assert
        XCTAssertTrue(viewModel.transactions.isEmpty)
    }
}
