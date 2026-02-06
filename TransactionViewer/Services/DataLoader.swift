//
//  DataLoader.swift
//  TransactionViewer
//
//  Created by Priyanka Vithani on 01/02/26.
//

import Foundation

protocol DataLoader {
    // Loads raw data from the given URL
    func load(from url: URL) throws -> Data
}

// Default file loader implementation
struct FileDataLoader: DataLoader {
    func load(from url: URL) throws -> Data {
        try Data(contentsOf: url)
    }
}
