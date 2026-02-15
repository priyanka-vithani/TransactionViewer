//
//  TransactionRepository.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 13/02/26.
//

import Foundation
actor TransactionRepository{
    private let network: NetworkProtocol
    init(network: NetworkProtocol) {
        self.network = network
    }
    func fetchTransactions() async throws -> [Transaction] {
        try Task.checkCancellation()
        let response: TransactionResponse<[Transaction]> = try await network.fetchLocal(.fetchLocal)
        try Task.checkCancellation()
        return await response.transactions
    }
}
