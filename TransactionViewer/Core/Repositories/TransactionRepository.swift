//
//  TransactionRepository.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 13/02/26.
//

import Foundation
final class TransactionRepository {
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

