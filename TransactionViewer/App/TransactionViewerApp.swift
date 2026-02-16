//
//  TransactionViewerApp.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 11/02/26.
//

import SwiftUI
// MARK: - Dependency Injection Container
enum DI {
    // Simple dependency container.
    // Allows swapping implementations (e.g. mock network) without changing feature code.
    static let networkManager: NetworkProtocol = NetworkManager()
    static let transRepo:TransactionRepository = TransactionRepository(network: networkManager)
    
    enum Preview {
        // TODO : mocks implementation
        static let networkManager: NetworkProtocol = NetworkManager()
        static let transRepo:TransactionRepository = TransactionRepository(network: networkManager)
    }
}

// MARK: - App Entry Point
@main
struct TransactionViewerApp: App {
    var body: some Scene {
        WindowGroup {
            TransactionListView(repo: DI.transRepo)
        }
    }
}
