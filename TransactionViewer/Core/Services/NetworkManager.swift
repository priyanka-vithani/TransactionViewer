//
//  NetworkManager.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 11/02/26.
//

import Foundation
// MARK: - API Endpoint
enum APIEndPoint {
    case fetchLocal
    
    var url: URL? {
        switch self {
        case .fetchLocal:
            guard let url = Bundle.main.url(forResource: "transaction-list", withExtension: "json") else {return nil}
            return url
        }
    }
}
// MARK: - Network Protocol
protocol NetworkProtocol {
    func fetchLocal<T>(_ url: URL) async throws -> T where T : Decodable
    func fetchLocal<T>(_ endPoint: APIEndPoint) async throws -> T where T : Decodable
}
// MARK: - Default Endpoint Implementation
extension NetworkProtocol {
    func fetchLocal<T>(_ endPoint: APIEndPoint) async throws -> T where T: Decodable {
        guard let url = endPoint.url else {
            throw JSONError.fileNotFound("transaction-list.json")
        }
        return try await fetchLocal(url)
    }
}
// MARK: - Network Manager
// Uses local JSON file instead of remote API as per assignment requirement.
// Structured to easily swap to real API calls in future.
final class NetworkManager: NetworkProtocol {
    // MARK: - Properties
    private let urlSession: URLSession
    private let decoder: JSONDecoder
    private var errorService: JSONError?
    
    // MARK: - Initializer
    // Initializer allowing for dependency injection of a URLSession, defaults to the shared session.
    init(urlSession: URLSession = .shared) {
        self.decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        // Date format matches "yyyy-MM-dd" provided in JSON file.
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        self.urlSession = urlSession
    }
    // MARK: - Fetch Local
    func fetchLocal<T>(_ url: URL) async throws -> T where T : Decodable {
        let data = try Data(contentsOf: url)
        return try decoder.decode(T.self, from: data)
    }
    
}


