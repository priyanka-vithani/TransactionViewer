//
//  MockRepository.swift
//  TransactionViewerTests
//
//  Created by Priyanka Vithani on 15/02/26.
//

import XCTest
@testable import TransactionViewer
final class MockRepository: TransactionRepositoryProtocol {

    var result: Result<[Transaction], Error>!

    func fetchTransactions() async throws -> [Transaction] {
        switch result! {
        case .success(let value): return value
        case .failure(let error): throw error
        }
    }
}
