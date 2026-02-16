//
//  TransactionListViewModel.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 11/02/26.
//

import Foundation
import Combine
import SwiftUI

// MARK: - Transaction List ViewModel

final class TransactionListViewModel: ObservableObject {
    
    // MARK: - View State
    // Represents UI rendering states.
    // Prevents invalid UI combinations (e.g. loading + data together).
    
    enum ViewState {
        case loading
        case loaded([TransactionRowUIModel])
        case failed(String)
    }
    
    // MARK: - Published Properties
    
    @Published private(set) var state: ViewState = .loading
    @Published var selectedTransaction: Transaction?
    
    // MARK: - Dependencies
    
    private let mapper: TransactionRowMapping
    private let repo: TransactionRepositoryProtocol
    
    // MARK: - Private Storage
    
    private var transactions: [Transaction] = []
    
    // MARK: - Initializer
    
    init(repo: TransactionRepositoryProtocol, mapper: TransactionRowMapping = TransactionRowMapper()) {
        self.repo = repo
        self.mapper = mapper
    }
    
    // MARK: - Public Methods
    
    func load() async {
        if case .loaded = state { return }
        
        state = .loading
        
        do {
            let result = try await repo.fetchTransactions()
            guard !Task.isCancelled else { return }
            
            transactions = result
            
            let uiModels = result.map(mapper.map)
            state = .loaded(uiModels)
            
        } catch {
            guard !Task.isCancelled else { return }
            state = .failed(error.localizedDescription)
        }
    }

    func select(id: String) {
           selectedTransaction = transactions.first(where: { $0.id == id })
       }
    func reload() async {
        state = .loading
        await load()
    }
}
