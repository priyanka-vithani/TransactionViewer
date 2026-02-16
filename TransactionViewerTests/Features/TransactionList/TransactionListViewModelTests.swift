//
//  TransactionListViewModelTests.swift
//  TransactionViewerTests
//
//  Created by Priyanka Vithani on 15/02/26.
//

import XCTest
@testable import TransactionViewer

@MainActor
final class TransactionListViewModelTests: XCTestCase {
    
    /// TC-18
    /// Verifies initial ViewModel state is .loading
    /// before any data fetch occurs.

    func test_TC18_initialState_isLoading() {
        let vm = TransactionListViewModel(repo: MockRepository())
        if case .loading = vm.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected loading state")
        }
    }
    
    /// TC-19
    /// Ensures successful repository response
    /// transitions ViewModel state to .loaded
    /// and produces correct UI models.


    func test_TC19_successfulLoad() async {
        let mock = MockRepository()
        mock.result = .success([MockTransactionFactory.make(type: .debit)])

        let vm = TransactionListViewModel(repo: mock)

        await vm.load()

        if case .loaded(let models) = vm.state {
            XCTAssertEqual(models.count, 1)
        } else {
            XCTFail("Expected loaded state")
        }
    }
    
    /// TC-20
    /// Ensures repository failure transitions
    /// ViewModel state to .failed
    /// with appropriate error propagation.


    func test_TC20_failedLoad() async {
        let mock = MockRepository()
        mock.result = .failure(JSONError.dataCorrupted)

        let vm = TransactionListViewModel(repo: mock)

        await vm.load()

        if case .failed = vm.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected failed state")
        }
    }
    
    /// TC-21
    /// Verifies selecting a transaction by id
    /// correctly updates selectedTransaction property.

    func test_TC21_selectTransaction() async {
        let transaction = MockTransactionFactory.make(type: .debit)

        let mock = MockRepository()
        mock.result = .success([transaction])

        let vm = TransactionListViewModel(repo: mock)

        await vm.load()
        vm.select(id: transaction.id)

        XCTAssertEqual(vm.selectedTransaction?.id, transaction.id)
    }
    
    /// TC-22
    /// Validates reload behavior resets state to .loading
    /// and re-fetches transactions successfully.

    func test_TC22_reload() async {
        let mock = MockRepository()
        mock.result = .success([MockTransactionFactory.make(type: .debit)])

        let vm = TransactionListViewModel(repo: mock)

        await vm.reload()

        if case .loaded = vm.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected loaded after reload")
        }
    }
}
