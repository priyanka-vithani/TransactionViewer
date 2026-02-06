//
//  TransactionListViewModel.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 31/01/26.
//

import SwiftUI

struct ExpandableCardView: View {
    
    @State private var isExpanded = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image("buddy-tip-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            
            Text(attributedText)
                .font(.subheadline)
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .overlay {
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
        }
    }
    // Generates dynamic attributed string based on expanded state
    private var attributedText: AttributedString {
        var text = AttributedString(
            "Transactions are processed Monday to Friday (excluding holidays). "
        )
        if isExpanded {
            text += AttributedString(
                "\n\nTransactions made before 8:30 pm ET Monday to Friday (excluding holidays) will show up in your account the same day. "
            )
            var showLess = AttributedString("show less")
            showLess.foregroundColor = .blue
            text += showLess
        } else {
            var showMore = AttributedString("show more")
            showMore.foregroundColor = .blue
            text += showMore
        }
        return text
    }
}
#Preview {
    ExpandableCardView()
}
