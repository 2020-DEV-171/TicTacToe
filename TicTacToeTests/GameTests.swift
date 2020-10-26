//
//  GameTests.swift
//  TicTacToeTests
//
//  Created by Marco Mustapic on 26/10/2020.
//

import XCTest
@testable import TicTacToe

class GameTests: XCTestCase {

    func testStart() {
        let game = Game()
        let expectedEvents: [TestGameDelegateEvent] = [
            .upated(.empty, .top, .left), .upated(.empty, .top, .center), .upated(.empty, .top, .right),
            .upated(.empty, .middle, .left), .upated(.empty, .middle, .center), .upated(.empty, .middle, .right),
            .upated(.empty, .bottom, .left), .upated(.empty, .bottom, .center), .upated(.empty, .bottom, .right),
            .turnChanged(.cross)
        ]
        let delegate = TestGameDelegate(expectation: expectation(description: "board is initialised and first turn is set to cross"), expectedEventCount: expectedEvents.count)
        game.delegate = delegate
        game.start()
        waitForExpectations(timeout: 0.05) { (error) in
            if let _ = error {
                XCTFail("Delegate not called")
            }
            XCTAssertEqual(expectedEvents, delegate.events)
        }
    }
    
    func testPlay() {
        let game = Game()
        let expectedEvents: [TestGameDelegateEvent] = [
            .upated(.cross, .top, .left),
            .turnChanged(.circle),
            .upated(.circle, .top, .center),
            .turnChanged(.cross)
        ]
        let delegate = TestGameDelegate(expectation: expectation(description: "board is initialised and first turn is set to cross"), expectedEventCount: expectedEvents.count)
        game.start()
        game.delegate = delegate
        game.play(row: .top, column: .left)
        game.play(row: .top, column: .center)
        waitForExpectations(timeout: 0.05) { (error) in
            if let _ = error {
                XCTFail("Delegate not called")
            }
            XCTAssertEqual(expectedEvents, delegate.events)
        }
    }
    
    func testCrossWon() {
        let game = Game()
        let expectedEvents: [TestGameDelegateEvent] = [
            .upated(.cross, .top, .left),
            .turnChanged(.circle),
            .upated(.circle, .top, .center),
            .turnChanged(.cross),
            .upated(.cross, .middle, .left),
            .turnChanged(.circle),
            .upated(.circle, .middle, .center),
            .turnChanged(.cross),
            .upated(.cross, .bottom, .left),
            .finished(.won(.cross))
        ]
        let delegate = TestGameDelegate(expectation: expectation(description: "board is initialised and first turn is set to cross"), expectedEventCount: expectedEvents.count)
        game.start()
        game.delegate = delegate
        game.play(row: .top, column: .left)
        game.play(row: .top, column: .center)
        game.play(row: .middle, column: .left)
        game.play(row: .middle, column: .center)
        game.play(row: .bottom, column: .left)
        waitForExpectations(timeout: 0.05) { (error) in
            if let _ = error {
                XCTFail("Delegate not called")
            }
            XCTAssertEqual(expectedEvents, delegate.events)
        }
    }
}
