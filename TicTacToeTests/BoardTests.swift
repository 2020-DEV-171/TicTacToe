//
//  BoardTests.swift
//  TicTacToeTests
//
//  Created by Marco Mustapic on 25/10/2020.
//

import XCTest
@testable import TicTacToe

class BoardTests: XCTestCase {

    func testBoardInitialization() {
        let board = Board()
        for position in Position.allCases {
            XCTAssertEqual(board.value(position: position), .empty, "Value at \(position) should be empty")
        }
    }

    func testBoardReset() {
        let board = Board()
        board.reset()
        for position in Position.allCases {
            XCTAssertEqual(board.value(position: position), .empty, "Value at \(position) should be empty")
        }
    }

    func testBoardSet() {
        let board = Board()
        board.setValue(value: .circle, position: .topLeft)
        XCTAssertEqual(board.value(position: .topLeft), .circle, "Value at topLeft should be circle")
    }

}
