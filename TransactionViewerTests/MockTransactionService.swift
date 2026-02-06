//
//  MockTransactionService.swift
//  TransactionViewerTests
//
//  Created by Priyanka Vithani on 01/02/26.
//

import Foundation
@testable import TransactionViewer

final class MockTransactionService: TransactionServiceProtocol{
    
    var shouldReturnTransaction: [Transaction] = []
    var errorToThrow: Error? = nil
    
    func fetchTransactions() async throws -> [Transaction] {
        if let error = errorToThrow {
            throw error
        }
        return shouldReturnTransaction
    }
}
