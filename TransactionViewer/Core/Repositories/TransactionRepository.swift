//
//  TransactionRepository.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 13/02/26.
//

import Foundation

// MARK: - Transaction Repository Protocol
protocol TransactionRepositoryProtocol {
    func fetchTransactions() async throws -> [Transaction]
}

// MARK: - Transaction Repository
// Repository abstracts data source from ViewModels.
// ViewModels do not directly depend on Network layer.
final class TransactionRepository:  TransactionRepositoryProtocol{
    // MARK: - Properties
    private let network: NetworkProtocol
    // MARK: - Initializer
    init(network: NetworkProtocol) {
        self.network = network
    }
    // MARK: - Public Methods
    /// Fetches transactions from local JSON file.
    /// - Returns: Array of Transaction domain models.
    /// - Throws: JSONError if file missing or decoding fails.
    func fetchTransactions() async throws -> [Transaction] {
        try Task.checkCancellation()
        let response: TransactionResponse =
            try await network.fetchLocal(.fetchLocal)
        return response.transactions
    }
}

