//
//  NetworkResponseService.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 11/02/26.
//

import Foundation

/// Protocol for describing HTTP response errors
protocol HTTPResponseDescribable {
    var description: String { get }
}
enum JSONError: Error, HTTPResponseDescribable {
    
    case fileNotFound(String)
    case dataCorrupted
    case decodingFailed(Error)

    var description: String {
        switch self {
        case .fileNotFound(let filename):
            return "JSON file \(filename) not found in bundle."
        case .dataCorrupted:
            return "Data is corrupted or empty."
        case .decodingFailed(let error):
            return "Decoding failed: \(error.localizedDescription)"
        }
    }
}
