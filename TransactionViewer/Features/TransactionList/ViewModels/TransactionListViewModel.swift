//
//  TransactionListViewModel.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 11/02/26.
//

import Foundation
import Combine
import SwiftUI
import Foundation
import SwiftUI

final class TransactionListViewModel: ObservableObject {
    
    enum ViewState {
        case loading
        case loaded([TransactionRowUIModel])
        case failed(String)
    }
    
    @Published private(set) var state: ViewState = .loading
    private let mapper: TransactionRowMapping
    private let repo: TransactionRepository
    private var transactions: [Transaction] = []
    @Published var selectedTransaction: Transaction?
    
    init(repo: TransactionRepository, mapper: TransactionRowMapping = TransactionRowMapper()) {
        self.repo = repo
        self.mapper = mapper
    }
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
    
    private func mapToRowUIModel(_ transaction: Transaction) -> TransactionRowUIModel {
        return TransactionRowUIModel(
            id: transaction.id,
            merchantName: transaction.merchantName,
            description: transaction.description ?? "",
            formattedAmount: AppCurrencyFormatter.string(from: transaction.amount),
            iconColor: transaction.type == .debit ? .red : .green,
            formattedDate: AppDateFormatter.display.string(from: transaction.postedDate),
            fromAccount: transaction.fromAccount,
            maskedCardNumber: CardMasking.masked(transaction.fromCardNumber)
        )
    }
}
