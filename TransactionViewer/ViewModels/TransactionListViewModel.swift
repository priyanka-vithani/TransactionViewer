//
//  TransactionListViewModel.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 30/01/26.
//

import Foundation
import Combine

@MainActor
final class TransactionListViewModel: ObservableObject {
    
    @Published private(set) var transactions: [Transaction] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    
    private let service: TransactionServiceProtocol
    
    init(service: TransactionServiceProtocol) {
        self.service = service
    }
    // Fetches transactions asynchronously and updates state
    func fetchTransactions() async {
        isLoading = true
        errorMessage = nil
        do {
            transactions = try await service.fetchTransactions()
        } catch {
            transactions = []
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
