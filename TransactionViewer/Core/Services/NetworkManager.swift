//
//  NetworkManager.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 11/02/26.
//

import Foundation

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


protocol NetworkProtocol {
    func fetchLocal<T>(_ url: URL) async throws -> T where T : Decodable
    func fetchLocal<T>(_ endPoint: APIEndPoint) async throws -> T where T : Decodable
}

extension NetworkProtocol {
    func fetchLocal<T>(_ endPoint: APIEndPoint) async throws -> T where T: Decodable {
        guard let url = endPoint.url else {
            throw JSONError.fileNotFound("transaction-list.json")
        }
        return try await fetchLocal(url)
    }
}

final class NetworkManager: NetworkProtocol {
    
    private let urlSession: URLSession
    
    private let decoder: JSONDecoder
    
    private var errorService: JSONError?
    
    // Initializer allowing for dependency injection of a URLSession, defaults to the shared session.
    init(urlSession: URLSession = .shared) {
        self.decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        self.urlSession = urlSession
    }
    
    func fetchLocal<T>(_ url: URL) async throws -> T where T : Decodable {
        let data = try Data(contentsOf: url)
        return try decoder.decode(T.self, from: data)
    }
    
}


