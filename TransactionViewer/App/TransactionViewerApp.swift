//
//  TransactionViewerApp.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 11/02/26.
//

import SwiftUI
enum DI {
    static let networkManager: NetworkProtocol = NetworkManager()
    static let transRepo:TransactionRepository = TransactionRepository(network: networkManager)
    
    enum Preview {
        // TODO : mocks implementation
        static let networkManager: NetworkProtocol = NetworkManager()
        static let transRepo:TransactionRepository = TransactionRepository(network: networkManager)
    }
}

@main
struct TransactionViewerApp: App {
    var body: some Scene {
        WindowGroup {
            TransactionListView(repo: DI.transRepo)
        }
    }
}
