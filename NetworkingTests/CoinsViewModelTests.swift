//
//  CoinsViewModelTests.swift
//  NetworkingTests
//
//  Created by Denis Dareuskiy on 8.08.24.
//

import Foundation
import XCTest
@testable import Networking

class CoinsViewModelTests: XCTestCase {
    func testInit() {
        let service = MockCoinService()
        let viewModel = CoinsViewModel(service: service)
        
        XCTAssertNotNil(viewModel, "nil")
    }
    
    func testSuccesfulCoinsFetch() async {
        let service = MockCoinService()
        let viewModel = CoinsViewModel(service: service)
        
        await viewModel.fetchCoins()
        XCTAssertTrue(viewModel.coins.count > 0)
    }
    
    func testCoinFetchWithInvalidJSON() async {
        
    }
    
    func throwsInvalidDataError() async {
        
    }
}
