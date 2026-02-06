//
//  TransactionService.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 30/01/26.
//

import Foundation

// Custom error for transaction fetching
enum TransactionServiceError: Error, LocalizedError {
    case fileNotFound
    case decodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound: return "Transaction file not found."
        case .decodingFailed(let error): return "Decoding failed: \(error.localizedDescription)"
        }
    }
}

// Protocol for dependency injection
protocol TransactionServiceProtocol {
    func fetchTransactions() async throws -> [Transaction]
}
// Concrete implementation using local file data
final class TransactionService: TransactionServiceProtocol {
    private let loader: DataLoader
    private let decoder: JSONDecoder
    private let fileName: String
    private let fileExtension: String
    
    init(loader: DataLoader = FileDataLoader(),
         decoder: JSONDecoder = JSONDecoder(),
         fileName: String = "transaction-list",
         fileExtension: String = "json") {
        self.loader = loader
        self.decoder = decoder
        self.fileName = fileName
        self.fileExtension = fileExtension
    }
    
    func fetchTransactions() async throws -> [Transaction] {
        // Load file URL
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            throw TransactionServiceError.fileNotFound
        }
        // Load raw data
        let data = try loader.load(from: url)
        // Decode JSON
        do {
            let response = try decoder.decode(TransactionResponse.self, from: data)
            return response.transactions
        } catch {
            throw TransactionServiceError.decodingFailed(error)
        }
    }
}
