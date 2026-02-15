//
//  TransactionListView.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 11/02/26.
//

import SwiftUI
struct TransactionListView: View {
    
    @StateObject private var viewModel: TransactionListViewModel
    
    init(repo: TransactionRepository) {
        _viewModel = StateObject(
            wrappedValue: TransactionListViewModel(repo: repo)
        )
    }
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Transactions")
                .navigationDestination(
                    item: $viewModel.selectedTransaction
                ) { transaction in
                    TransactionDetailView(
                        transaction: transaction
                    )
                }
                .task {
                    await viewModel.load()
                }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
            
        case .loading:
            ProgressView("Loading transactions…")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .failed(let message):
            VStack(spacing: 16) {
                Text(message)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                
                Button("Retry") {
                    Task {
                        await viewModel.reload()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            
        case .loaded(let transactions):
            List(transactions) { transaction in
                Button {
                    viewModel.select(id: transaction.id)
                } label: {
                    TransactionRowView(transaction: transaction)
                }
            }
            .listStyle(.plain)
        }
    }
}



#Preview {
    TransactionListView(repo: DI.Preview.transRepo)
}
