//
//  ViewModelTests.swift
//  TicTacToeTests
//
//  Created by Marco Mustapic on 27/10/2020.
//

import XCTest
@testable import TicTacToe

class ViewModelTests: XCTestCase {
    
    func testViewModelStart() {
        let viewModel = ViewModel()
        let expectedEvents: [TestViewModelDelegateEvent] = [
            .setBoardButtonTitle("", .topLeft), .setBoardButtonTitle("", .topCenter), .setBoardButtonTitle("", .topRight),
            .setBoardButtonTitle("", .middleLeft), .setBoardButtonTitle("", .middleCenter), .setBoardButtonTitle("", .middleRight),
            .setBoardButtonTitle("", .bottomLeft), .setBoardButtonTitle("", .bottomCenter), .setBoardButtonTitle("", .bottomRight),
            .setCurentPlayer("Current player: X")
        ]
        let delegate = TestViewModelDelegate(expectation: expectation(description: "current player name is set to X"), expectedEventCount: 1)
        viewModel.delegate = delegate
        viewModel.start()
        waitForExpectations(timeout: 0.05) { (error) in
            if let _ = error {
                XCTFail("Delegate not called")
            }
            XCTAssertEqual(expectedEvents, delegate.events)
        }
    }
    
    func testViewModelPlay() {
        let viewModel = ViewModel()
        let expectedEvents: [TestViewModelDelegateEvent] = [.setBoardButtonTitle("X", .topLeft), .setCurentPlayer("Current player: O")]
        let delegate = TestViewModelDelegate(expectation: expectation(description: "current player name is set to X"), expectedEventCount: 1)
        viewModel.start()
        viewModel.delegate = delegate
        viewModel.play(at: .topLeft)
        waitForExpectations(timeout: 0.05) { (error) in
            if let _ = error {
                XCTFail("Delegate not called")
            }
            XCTAssertEqual(expectedEvents, delegate.events)
        }
    }
}
