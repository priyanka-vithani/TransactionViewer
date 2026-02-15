//
//  TransactionRepository.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 13/02/26.
//

import Foundation
protocol TransactionRepositoryProtocol {
    func fetchTransactions() async throws -> [Transaction]
}

final class TransactionRepository:  TransactionRepositoryProtocol{
    private let network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func fetchTransactions() async throws -> [Transaction] {
        try Task.checkCancellation()
        let response: TransactionResponse =
            try await network.fetchLocal(.fetchLocal)
        return response.transactions
    }
}

