//
//  BoardTests.swift
//  TicTacToeTests
//
//  Created by Marco Mustapic on 25/10/2020.
//

import XCTest
@testable import TicTacToe

class TicTacToeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBoardInitialization() {
        let board = Board()
        for row in BoardRow.allCases {
            for column in BoardColumn.allCases {
                XCTAssertEqual(board.value(row: row, column: column), .empty, "Value at (\(row),\(column)) should be empty")
            }
        }
    }

    func testBoardReset() {
        let board = Board()
        board.reset()
        for row in BoardRow.allCases {
            for column in BoardColumn.allCases {
                XCTAssertEqual(board.value(row: row, column: column), .empty, "Value at (\(row),\(column)) should be empty")
            }
        }
    }

    func testBoardSet() {
        let board = Board()
        board.setValue(value: .circle, row: .top, column: .left)
        XCTAssertEqual(board.value(row: .top, column: .left), .circle, "Value at (top,left) should be circle")
    }

}
