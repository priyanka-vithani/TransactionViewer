//
//  MockNetwork.swift
//  TransactionViewerTests
//
//  Created by Priyanka Vithani on 15/02/26.
//

import XCTest
import Foundation
@testable import TransactionViewer

final class MockNetwork: NetworkProtocol {

    var result: Result<TransactionResponse, Error>!

    func fetchLocal<T>(_ url: URL) async throws -> T where T : Decodable {
        switch result! {
        case .success(let response):
            return response as! T
        case .failure(let error):
            throw error
        }
    }

    func fetchLocal<T>(_ endPoint: APIEndPoint) async throws -> T where T : Decodable {
        return try await fetchLocal(URL(fileURLWithPath: ""))
    }
    
}
