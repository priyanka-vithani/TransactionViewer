//
//  TransactionView.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 30/01/26.
//

import SwiftUI

struct TransactionRowView: View {
    var transaction: Transaction
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(transaction.merchantName).multilineTextAlignment(.leading)
                if let desc = transaction.description{
                    Text(desc).font(.subheadline).foregroundStyle(.secondary)
                }
                Text(transaction.fromCardNumber.formatSecureCardNumber()).font(.caption).foregroundStyle(.secondary)
                Text(transaction.postedDate.toReadableDate()).font(.caption).foregroundStyle(.secondary)
            }
            Spacer(minLength: 16)
            Text(transaction.amount.value, format: .currency(code: transaction.amount.currency)).font(Font.headline)
        }
    }
}

#Preview {
    @Previewable @State var transaction = Transaction(id: "kDk81_4xGkWW_vOVP_ExwK7GVUlzQ5YtYcuZARHuAQg=", type: .debit, merchantName: "Mb - Cash Advance To - 1785", description: "Bill payment", amount: Amount(value: 200.20, currency: "CAD"), postedDate: "2025-10-21", fromAccount: "Momentum Regular Visa", fromCardNumber: "4537350001688012")
    TransactionRowView(transaction: transaction)
}
