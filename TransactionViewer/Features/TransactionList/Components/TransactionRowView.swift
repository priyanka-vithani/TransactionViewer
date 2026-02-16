//
//  TransactionView.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 30/01/26.
//

import SwiftUI
// MARK: - Transaction Row View
struct TransactionRowView: View {
    // MARK: - Properties
    var transaction: TransactionRowUIModel
    // MARK: - Body
    var body: some View {
        HStack(alignment: .firstTextBaseline){
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(transaction.iconColor)
            VStack(alignment: .leading){
                Text(transaction.merchantName).multilineTextAlignment(.leading)
                Text(transaction.maskedCardNumber).font(.caption).foregroundStyle(.secondary)
                HStack{
                    Text(transaction.description).font(.subheadline).foregroundStyle(.secondary)
                    Text("•")
                    Text(transaction.formattedDate).font(.caption).foregroundStyle(.secondary)
                }
            }
            Spacer(minLength: 16)
            Text(transaction.formattedAmount)
        }
    }
}

#Preview {
    TransactionRowView(
        transaction: TransactionRowUIModel(
                id: "sample-id",
                merchantName: "Mb - Cash Advance To - 1785",
                description: "Bill payment",
                formattedAmount: "$200.20",
                iconColor: .red,
                formattedDate: "Oct 21, 2025",
                fromAccount: "Momentum Regular Visa",
                maskedCardNumber: "**** 8012"
            )
        )
}
