//
//  TransactionList.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 30/01/26.
//

import SwiftUI

struct TransactionListView: View {
    @StateObject private var viewModel: TransactionListViewModel
    // Dependency injection
    init(service: TransactionServiceProtocol = TransactionService()) {
        _viewModel = StateObject(wrappedValue: TransactionListViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading transactions…")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if viewModel.transactions.isEmpty {
                    Text("No transactions available")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(viewModel.transactions) { transaction in
                        NavigationLink {
                            TransactionDetailView(transaction: transaction)
                        } label: {
                            TransactionRowView(transaction: transaction)
                        }
                    }
                }
            }
            .navigationTitle("Transactions")
            .task {
                await viewModel.fetchTransactions()
            }
        }
    }
}

#Preview {
    TransactionListView()
}
