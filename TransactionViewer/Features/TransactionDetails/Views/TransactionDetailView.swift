//
//  TransactionDetailView.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 31/01/26.
//

import SwiftUI
// MARK: - Transaction Detail View
struct TransactionDetailView: View {
    

    // MARK: - Environment
    @Environment(\.dismiss) var dismiss
    // MARK: - State
    @StateObject private var viewModel: TransactionDetailViewModel
    // MARK: - Initializer
       init(transaction: Transaction) {
           _viewModel = StateObject(
               wrappedValue: TransactionDetailViewModel(transaction: transaction)
           )
       }
    // MARK: - Body
    var body: some View {
        ZStack{
            Color(.systemBackground).ignoresSafeArea()
            VStack{
                titleView
                    .padding()
                detailsView
                Spacer()
                    .frame(height: 25)
                ExpandableCardView()
                    .padding()
                Spacer()
                closeButton
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(content: {
                RoundedRectangle(cornerRadius: 16).stroke(Color(.systemGray3), lineWidth: 1)
            })
            .shadow(color: Color(.systemGray).opacity(0.3), radius: 5, x: 0, y: 2)
            .padding()
            .navigationTitle("Transaction Details")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
        }
    }
    // MARK: - View Components
    // Transaction type + icon
    var titleView: some View {
        VStack{
            Image("success-icon")
                .foregroundColor(viewModel.iconColor)
            
            Text(viewModel.title)
                .font(.title)
        }
    }
    // Transaction details
    var detailsView: some View{
        return VStack(alignment: .leading){
            Text("From")
                .foregroundStyle(.secondary)
                .font(.subheadline)
            Text(viewModel.formattedFromAccount)
            Divider()
            Text("Amount")
                .foregroundStyle(.secondary)
                .font(.subheadline)
            Text(viewModel.formattedAmount)
        }.padding()
    }
    // Close button
    var closeButton: some View{
        
        Button {
            dismiss()
        } label: {
            Text("Close")
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundStyle(.white)
                .background(.red)
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .font(.headline)
        .bold()
    }
    
}

#Preview {
    @Previewable @State var transaction = Transaction(id: "kDk81_4xGkWW_vOVP_ExwK7GVUlzQ5YtYcuZARHuAQg=", type: .debit, merchantName: "Mb - Cash Advance To - 1785", description: "Bill payment", amount: Amount(value: 200.20, currency: "CAD"), postedDate: Date(), fromAccount: "Momentum Regular Visa", fromCardNumber: "4537350001688012")
    TransactionDetailView(transaction: transaction)
}
