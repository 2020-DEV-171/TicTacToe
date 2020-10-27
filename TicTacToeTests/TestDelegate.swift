//
//  TestDelegate.swift
//  TicTacToeTests
//
//  Created by Marco Mustapic on 27/10/2020.
//

import XCTest
@testable import TicTacToe

class TestDelegate<E> {
    private let expectation: XCTestExpectation
    private let expectedEventCount: Int
    var events: [E] = []

    init(expectation: XCTestExpectation, expectedEventCount: Int) {
        self.expectation = expectation
        self.expectedEventCount = expectedEventCount
    }

    func eventArrived(event: E) {
        events.append(event)
        if events.count == expectedEventCount {
            expectation.fulfill()
        }
    }
}
