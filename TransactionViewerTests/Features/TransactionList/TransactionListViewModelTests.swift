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

    func test_TC18_initialState_isLoading() {
        let vm = TransactionListViewModel(repo: MockRepository())
        if case .loading = vm.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected loading state")
        }
    }
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
    func test_TC21_selectTransaction() async {
        let transaction = MockTransactionFactory.make(type: .debit)

        let mock = MockRepository()
        mock.result = .success([transaction])

        let vm = TransactionListViewModel(repo: mock)

        await vm.load()
        vm.select(id: transaction.id)

        XCTAssertEqual(vm.selectedTransaction?.id, transaction.id)
    }
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
